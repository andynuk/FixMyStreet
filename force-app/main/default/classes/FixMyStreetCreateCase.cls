global with sharing class FixMyStreetCreateCase {

      
    public class Child {
    public String name;
    public String label;
    public String fieldType;
    public String length;
    public String[] optionsList = new String[] {};
	}
    
    
    public static Child[] GetFixMyStreetExtends(string FixMyStreetId) {
       
        Child[] resultList = new Child[] {};
        
       Child cAddInfoTitle = new Child();
       cAddInfoTitle.name = 'title__c';
       cAddInfoTitle.label = 'Short Summary of Problem';
       cAddInfoTitle.fieldType = 'text';
       cAddInfoTitle.length = '1000';
       resultList.add(cAddInfoTitle);

        // always in the basics
       Child cAddInfoDesc = new Child();
       cAddInfoDesc.name = 'Description__c';
       cAddInfoDesc.label = 'Description of problem';
       cAddInfoDesc.fieldType = 'text';
       cAddInfoDesc.length = '1000';
       resultList.add(cAddInfoDesc);
       
        
        
        
        
        // need to look up friendly description of code from id
        FixMyStreetSendCategories__mdt res_category =  database.query('SELECT service_code__c FROM FixMyStreetSendCategories__mdt where Live__C=true and Id=:FixMyStreetId');
        string servicecategory = res_category.service_code__c;
            
        Map<String, Schema.SObjectField> fieldsResult = Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap();
        //get object fields
        List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap().keySet());
        String fields = String.join(fieldList,',');       
            
            for (String fieldName: fieldsResult.keySet()) {
               if (fieldName.startsWithIgnoreCase('Extends_'+servicecategory))
                {
                 Child c = new Child();
        		 c.name = fieldname;
        		 c.label = fieldsResult.get(fieldname).getDescribe().getLabel();
                 Schema.DisplayType fielddataType = fieldsResult.get(fieldname).getDescribe().getType();
                    if (fielddataType == Schema.DisplayType.String) {
				   	 	c.fieldType = 'text';
                        Integer length = fieldsResult.get(fieldname).getDescribe().getLength();
                        c.length = String.valueOf(length);
                    } else if (fielddataType == Schema.DisplayType.TextArea) {
				   	 	c.fieldType = 'text';
                        Integer length = fieldsResult.get(fieldname).getDescribe().getLength();
                        c.length = String.valueOf(length);
                    } else if (fielddataType == Schema.DisplayType.Picklist) {
				   	 	c.fieldType = 'options';
                        List<Schema.PicklistEntry>Picks =fieldsResult.get(fieldname).getDescribe().getpicklistValues();
                        for (Schema.PicklistEntry pick: Picks) {
                        c.optionsList.add(pick.getValue());
                        }
                    } 
        		 resultList.add(c);
                }    
    		}
       // always add in additional information
       Child cAddInfoAdd = new Child();
       cAddInfoAdd.name = 'extends_additional_information__c';
       cAddInfoAdd.label = 'Additional Information';
       cAddInfoAdd.fieldType = 'text';
       cAddInfoAdd.length = '1000';
       resultList.add(cAddInfoAdd);

        
        //string result  = JSON.serializePretty(resultList); 
        //return result;
        return resultList;
       }

    
	@InvocableMethod
    public static void doCreationCase(List<FMSRequests> requests) {

        
        if (requests == null)
       {
           system.debug('No id sent to doCreationCase');
           return;
       }

        FMSRequests firstRequest = requests[0];
        
       Id fixmystreetId = firstRequest.fixmystreetId;
       boolean force = firstRequest.force;
       system.debug('doCreationCase '+ fixmystreetId);
        NewCaseFromFixMyStreetId(fixmystreetId,force);
    }

    
    global  class FMSRequests {
        @InvocableVariable
        global Id fixmystreetId;
        @InvocableVariable
        global boolean force = false;
    }

    public static void ConfirmLogEntry(string log) {
        // send the result to the log object
        FixMyStreet_Log__c logEntry = new FixMyStreet_Log__c();
        logEntry.Log__c = log;
        insert logEntry;
    }
    
    @future (callout=true)
    public static void NewCaseFromFixMyStreetId(Id fixmystreetId, boolean force) {


        system.debug(fixmystreetId);

        // force set to true
        // if we need to create case and remove confirm reference

        Boolean logError = false;
        string logEntry = 'NewCaseFromFixMyStreetId\r\n';
        
		FixMyStreet__c fixmystreet;
        fixmystreet = [SELECT id, Name, Service_Area__c,Service_Area__r.Name,title__c,Description__c,Easting__c, Northing__c,
                        requested_datetime__c,Contact_Name__c,Contact_Phone__c,Contact_Email__c,service_request_id__c,
                       lat__c, long__c,
                        Location__c, SiteCode__c,
                       ConfirmReference__c
                        FROM FixMyStreet__c 
                        WHERE FixMyStreet__c.id = :fixmystreetId
                        LIMIT 1
                       ];

        system.debug(fixmystreet);
        
        
        
        Id cat = fixmystreet.Service_Area__c;
        string ServiceArea = fixmystreet.Service_Area__r.Name;
        system.debug(ServiceArea);
        system.debug(cat);

        // check if we should integrate to Confirm and therefore not setup a case
        FixMyStreetCategories__c categoryCheck;
        categoryCheck = [SELECT Send_to_Confirm__c, InternalQueue__c FROM FixMyStreetCategories__c where Id=: cat LIMIT 1];
       // sendEmailMessage('SALESFORCE - Debug New Confirm Entry - 2', '2', 'anix@rutland.gov.uk');
        
        if (categoryCheck!=null && !force)
        {
            if (categoryCheck.Send_to_Confirm__c == true)
            {
                // in wrong place return 
       			 system.debug('---This category integrates to Confirm so case creation not allowed---');
                return;
            }
        }
        
        
	      //  need a list of all the extend fields in the record
    	Child[] resultList = GetFixMyStreetExtends(cat); 
   		System.debug(resultList);

        string soql = 'SELECT ';
        for (Child indList : resultList)
                {
                    //system.debug(indList.Name);
                    soql = soql + indList.Name + ', ';
                }
        soql = soql + 'Name FROM FixMyStreet__c WHERE FixMyStreet__c.id = \''+fixmystreetId+ '\' LIMIT 1';
		system.debug(soql);
        
		FixMyStreet__c fixmystreetExtend;
        fixmystreetExtend = Database.query(soql);
        system.debug('====Extends====');
        system.debug(fixmystreetExtend);
        
        // We have a the Id of the Service Area
        
       
        
        string fullDescription = '';
        string newline = '\r\n';
        if (fixmystreet.title__c != null)
            {
            fullDescription = fullDescription + 'Summary: '+fixmystreet.title__c+newline;
            }
        if (fixmystreet.Description__c != null)
            {
	        fullDescription = fullDescription + 'Description: '+fixmystreet.Description__c+newline;
            }
        
        for (Child indList : resultList)
                {
                    Object fieldval = fixmystreetExtend.get(indList.Name);
                    system.debug('=====');
                    system.debug(fieldval);
                    if (indList.Name != 'title__c'  && indList.Name != 'Description__c' && fieldval != null)
                    {
                        if (fieldval.ToString() != '')
                        {
                        fullDescription = fullDescription + indList.label + ': '+fieldval.ToString()+newline;
                        }
                    }
                }
        system.debug(fullDescription); 


    
        
        Datetime dateEnquiryLogtime;
        if (fixmystreet.requested_datetime__c != null)
        {
            dateEnquiryLogtime = fixmystreet.requested_datetime__c;
        }
        else
        {
            dateEnquiryLogtime = DateTime.now();
        }
        
        
        
        string enquiryLogTime = dateEnquiryLogtime.format('yyyy-MM-dd\'T\'HH:mm');
        string CSTlocation = '';
        if (fixmystreet.Location__c != null)
        {
            CSTlocation = fixmystreet.Location__c;
        }
        string crmRef = fixmystreet.Name;
        string custSurname = 'Not Known';
        if (fixmystreet.Contact_Name__c != null)
        {
            custSurname = fixmystreet.Contact_Name__c;
        }
        string custPhone = '';
        if (fixmystreet.Contact_Phone__c != null)
        {
            custPhone = fixmystreet.Contact_Phone__c;
        }
        string custEmail = '';
        if (fixmystreet.Contact_Email__c != null)
        {
            custEmail = fixmystreet.Contact_Email__c;
        }
        
        

        system.debug('---ready to create case----');
        
        
        string orgId = UserInfo.getOrganizationId();
        system.debug('OrgId: '+orgId);
        boolean production = false;
        if (orgId == '00D0Y000002EzYY')
        {
            production = true;
        }
        
        
            
        
        
        string body = '';
        if (fixmystreet.service_request_id__c>0)
        {
            body = body + 'Recorded via the National FixMyStreet Service'+newline;
        }
        else
        {
            body = body + 'Recorded via Customer Services Team'+newline;
        }
        
        
        body = body + fullDescription+newline;
        if (CSTLocation != '')
        {
	        body = body + 'CST Described Location: '+CSTLocation+newline;        
        }
        body = body + 'Name: '+custSurname+newline;        
        body = body + 'Phone: '+custPhone+newline;
        body = body + 'Email: '+custEmail+newline;
        body = body + 'Area: '+ServiceArea +newline;
        
        System.debug(body);
       logEntry = logEntry + body+newline;                
       
        // was manually entered         '00G6E000003jeo1';
        // 
        Id caseRecordTypeId = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('FixMyStreet').getRecordTypeId();
        //Id ownerId = Schema.getGlobalDescribe().getSObjectType().getDescribe().getRecordTypeInfosByName().get('Internal Street Scene Waste Queue').getRecordTypeId();

        //newCase.OwnerId = '00G6E000003jeo1';
        string owner = categoryCheck.InternalQueue__c;
        system.debug(owner);
		//List<queueSobject> queues = [select queue.id from queueSobject where queue.Name = 'Internal Street Scene Waste Queue'];
        
		List<queueSobject> queues = [select queue.id from queueSobject where queue.Name =: owner];
        
        Id ownerId = null;
        if (queues.size() >0)
        {
            ownerId = queues[0].queue.id;
        }
        else
        {
            // problem with no queue found
			queues = [select queue.id from queueSobject where queue.Name = 'CST Main Queue'];
            if (queues.size()>0)
        		{
            	ownerId = queues[0].queue.id;
        		}
        }
        system.debug(ownerId);
        
		Case newCase = new Case();
        if (ownerid!=null)
        {
        newCase.OwnerId = ownerId;
        }
        //newCase.OwnerId = '00G6E000003jeo1';
        newCase.RecordTypeId = caseRecordTypeId;
        newCase.Service_Area__c = 'Street Scene';
        // if we have force then may not be a street scene service area
        if (!force)
        {
        newCase.Service_Area_Detail__c = ServiceArea;
        }
        newCase.Subject = ServiceArea + ' - ' + fixmystreet.title__c;
        newCase.Customer_Services_Comments__c = CSTLocation;
        newCase.Description = body;

		
		insert newCase;                               
        
        //now link case and FxMyStreet record
     	fixmystreet.Case__c = newCase.Id;
        if (force)
        {
            // remove any confirm reference
            fixmystreet.ConfirmReference__c = null;
        }
        upsert fixmystreet;
        
       if (logError)
      {
          ConfirmLogEntry(logEntry);
      }
        
    }

    
}