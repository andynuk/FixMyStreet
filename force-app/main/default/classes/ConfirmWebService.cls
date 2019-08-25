global with sharing class ConfirmWebService {

/*
     @future (callout=true)
    public static void sendGetEnquiryLookups() {

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        string body = '<?xml version="1.0" encoding="utf-8"?>';
        body = body + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
		body = body + '<soap12:Body>';
		body = body + '<ProcessOperationsRequest xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
		body = body + '<Request xmlns="">';
		body = body + '<Authentication>';
		body = body + '<Username>SFCRM</Username>';
		body = body + '<Password>Enquir1es</Password>';
		body = body + '<DatabaseId>Rutland County Council and Tarmac - Development</DatabaseId>';
		body = body + '</Authentication>';
		body = body + '<Operation>';
		body = body + '<GetEnquiryLookups/>';
		body = body + '</Operation>';
		body = body + '</Request>';
		body = body + '</ProcessOperationsRequest>';
		body = body + '</soap12:Body>';
		body = body + '</soap12:Envelope>';
        
        //System.debug(body);
        
        
        req.setEndpoint('https://development-connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('Charset', 'UTF-8');

        req.setBody(body);
        
        

        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }

//        System.debug(res.toString());
        System.debug(res.getBody());

        Dom.Document doc = res.getBodyDocument();
        System.debug('Dom.Document ====>');
        System.debug(doc);
        Dom.XMLNode node = doc.getRootElement();
        System.debug('node ====>');
        System.debug(node);
        

    }
    
    
    @future (callout=true)
    public static void GetEnquiryLookups(string EnquiryNo) {

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        string body = '<?xml version="1.0" encoding="utf-8"?>';
        body = body + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
		body = body + '<soap12:Body>';
		body = body + '<ProcessOperationsRequest xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
		body = body + '<Request xmlns="">';
		body = body + '<Authentication>';
		body = body + '<Username>SFCRM</Username>';
		body = body + '<Password>Enquir1es</Password>';
		body = body + '<DatabaseId>Rutland County Council and Tarmac - Development</DatabaseId>';
		body = body + '</Authentication>';
		body = body + '<Operation>';
		body = body + '<GetEnquiry><EnquiryNumber>'+EnquiryNo+'</EnquiryNumber></GetEnquiry>';
		body = body + '</Operation>';
		body = body + '</Request>';
		body = body + '</ProcessOperationsRequest>';
		body = body + '</soap12:Body>';
		body = body + '</soap12:Envelope>';
        
        //System.debug(body);
        
        
        req.setEndpoint('https://development-connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('Charset', 'UTF-8');

        req.setBody(body);
        
        

        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }

//        System.debug(res.toString());
        System.debug(res.getBody());

        Dom.Document doc = res.getBodyDocument();
        System.debug('Dom.Document ====>');
        System.debug(doc);
        Dom.XMLNode node = doc.getRootElement();
        System.debug('node ====>');
        System.debug(node);
        

    }
    
    @future (callout=true)
    public static void NewEnquiry() {

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        string body = '<?xml version="1.0" encoding="utf-8"?>';
        body = body + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
		body = body + '<soap12:Body>';
		body = body + '<ProcessOperationsRequest xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
		body = body + '<Request xmlns="">';
		body = body + '<Authentication>';
		body = body + '<Username>SFCRM</Username>';
		body = body + '<Password>Enquir1es</Password>';
		body = body + '<DatabaseId>Rutland County Council and Tarmac - Development</DatabaseId>';
		body = body + '</Authentication>';
		body = body + '<Operation>';
		body = body + '<NewEnquiry>';
        body = body + '<EnquiryNumber>1</EnquiryNumber>';
        body = body + '<ServiceCode>C016</ServiceCode>';
        body = body + '<SubjectCode>C054</SubjectCode>';
        body = body + '<EnquiryDescription>large TESTING pothole in road.  TESTING</EnquiryDescription>';
        body = body + '<EnquiryLocation>car park entrance</EnquiryLocation>';
        body = body + '<EnquiryStatusCode>1000</EnquiryStatusCode>';
        body = body + '<AssignedOfficerCode>MAHA</AssignedOfficerCode>';
        body = body + '<StatusLogNotes>StatusLogNotes</StatusLogNotes>';
        body = body + '<LoggedTime>2018-10-04T12:31:21</LoggedTime>';
        body = body + '<EnquiryX>486306.21</EnquiryX>';
        body = body + '<EnquiryY>308570.32</EnquiryY>';
        body = body + '<SiteCode>33200105</SiteCode>';
        body = body + '<CentralAssetId></CentralAssetId>';
        body = body + '<ContactName>Andy Nix</ContactName>';
        body = body + '<ContactPhone>01572 577277</ContactPhone>';
        body = body + '<ContactEmail>anix@rutland.gov.uk</ContactEmail>';
        body = body + '<EnquiryReference>SalesforceRef</EnquiryReference>';
        body = body + '<EnquiryClassCode></EnquiryClassCode>';
        body = body + '<NoticeFromOrgCode></NoticeFromOrgCode>';
        body = body + '<WorksReference></WorksReference>';
        body = body + '</NewEnquiry>';
		body = body + '</Operation>';
		body = body + '</Request>';
		body = body + '</ProcessOperationsRequest>';
		body = body + '</soap12:Body>';
		body = body + '</soap12:Envelope>';
        
        //System.debug(body);
        
        
        req.setEndpoint('https://development-connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('Charset', 'UTF-8');

        req.setBody(body);
        
        

        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }

//        System.debug(res.toString());
        System.debug(res.getBody());

        Dom.Document doc = res.getBodyDocument();
        System.debug('Dom.Document ====>');
        System.debug(doc);
        Dom.XMLNode node = doc.getRootElement();
        System.debug('node ====>');
        System.debug(node);
        

    }

    public static void updateFixMyStreetEastNorthFromId(Id fixmystreetId) {
		List<FixMyStreet__c> fixmystreets;
        fixmystreets = [SELECT id, Easting__c, Northing__c,lat__c,long__c FROM FixMyStreet__c WHERE FixMyStreet__c.id = :fixmystreetId];
        FixMyStreet__c fixmystreet = fixmystreets[0];

        string X =   String.valueOf(fixmystreet.Easting__c);
        string Y =   String.valueOf(fixmystreet.Northing__c);
    
        string lat =   String.valueOf(fixmystreet.lat__c);
        string lng =   String.valueOf(fixmystreet.long__c);
        
        string url = 'https://www.bgs.ac.uk/data/webservices/CoordConvert_LL_BNG.cfc?method=LatLongToBNG&lat='+lat+'&lon='+lng;
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Length','0');

         
        

        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }        
   
        
        System.debug(res.getBody());

        Map<String, Object> m = (Map<String, object>) JSON.deserializeUntyped(res.getBody());
        System.debug('------');
        System.debug(m);
        System.debug('------');
        System.debug(m.keySet());
        System.debug(m.get('EASTING'));
        System.debug(m.get('NORTHING'));
        
        // when the record is returned a unique payment reference is created
        Double easting = Double.valueOf(m.get('EASTING'));
        Double northing = Double.valueOf(m.get('NORTHING'));
        
        System.debug(easting);
        System.debug(northing);
        
        fixmystreet.Easting__c =  easting;
        fixmystreet.Northing__c =  northing;
         upsert fixmystreet;                               
        
    }

*/
      
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
        FixMyStreetCategories__c res_category =  database.query('SELECT service_code__c FROM FixMyStreetCategories__c where Live__C=true and Id=:FixMyStreetId');
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
    public static void doCreationConfirmRecord(List<FMSRequests> requests) {

        
        if (requests == null)
       {
           system.debug('No id sent to doCreationConfirmRecord');
           return;
       }

        FMSRequests firstRequest = requests[0];
        
       Id fixmystreetId = firstRequest.fixmystreetId;
       boolean force = firstRequest.force;
       system.debug('NewConfirmEnquiryFromId '+ fixmystreetId);
        NewConfirmEnquiryFromId(fixmystreetId,force);
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
    public static void NewConfirmEnquiryFromId(Id fixmystreetId, boolean force) {


        system.debug(fixmystreetId);

        //sendEmailMessage('SALESFORCE - Debug New Confirm Entry - 1', '1', 'anix@rutland.gov.uk');

        Boolean logError = false;
        string logEntry = 'NewConfirmEnquiryFromId\r\n';
        
		FixMyStreet__c fixmystreet;
        fixmystreet = [SELECT id, Name, Service_Area__c,title__c,Description__c,Easting__c, Northing__c,
                        requested_datetime__c,Contact_Name__c,Contact_Phone__c,Contact_Email__c,
                       lat__c, long__c,
                        Location__c, SiteCode__c,
                       ConfirmReference__c
                        FROM FixMyStreet__c 
                        WHERE FixMyStreet__c.id = :fixmystreetId
                        LIMIT 1
                       ];

        system.debug(fixmystreet);
        
        Id cat = fixmystreet.Service_Area__c;
        system.debug(cat);

        // check if we should integrate to Confirm
        FixMyStreetCategories__c confirmCheck;
        confirmCheck = [SELECT Send_to_Confirm__c FROM FixMyStreetCategories__c where Id=: cat LIMIT 1];
       // sendEmailMessage('SALESFORCE - Debug New Confirm Entry - 2', '2', 'anix@rutland.gov.uk');
        
        if (confirmCheck!=null && force!=true)
        {
            if (confirmCheck.Send_to_Confirm__c == false)
            {
                // in wrong place return
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
        // In FixMyStreetToConfirm is the date that gets the Service Code and Subject code to be passed
        // Each record type has a picklist field that drives the subject code
        // Road and Highways	RC01	Extends_RC01_Highways_Defects__c	Pothole	is C016 C054
        // Road and Highways	RC01	Extends_RC01_Highways_Defects__c	Obstruction	is C016 C052
        // So first make a call to find the field to use
        // Then make a call to find what value is in this field in our incoming record
        // Then make a call to the FixMyStreetToConfirm to get the Service Code and Subect Code
        // So if we have an Road and Highway record coming in
        // Look up to see that is it Extends_RC01_Highways_Defects__c
        // Find the value e.g. Pothole
        // Find the FixMyStreetToConfirm with Road and Highways and Pothole to get Service Code and Subect Code
        string ConfirmServiceCode = '';
        string ConfirmSubjectCode = '';

        //sendEmailMessage('SALESFORCE - Debug New Confirm Entry - 4', '4', 'anix@rutland.gov.uk');
        
        try
            {
            List<FixMyStreetToConfirm__c> fixmystreetToConfirm;
            fixmystreetToConfirm = [SELECT FixMyStreetCategories__c , SecondField__c FROM FixMyStreetToConfirm__c WHERE FixMyStreetCategories__c  = :cat LIMIT 1]; 
            
             String secondField = '';
            String secondFieldValue = '';    
             
            if (fixmystreetToConfirm == null)
            {
                system.debug('---no results returned----');
                secondField = 'Error';
            }
                else
            {
            system.debug('---secondField results returned----');
            secondField = fixmystreetToConfirm[0].SecondField__c;
            System.debug(secondField);
            
            System.debug(fixmystreetExtend.get(secondField));    
            secondFieldValue = fixmystreetExtend.get(secondField).ToString();
            System.debug(secondFieldValue);
            }
            
            List<FixMyStreetToConfirm__c> fixmystreetToConfirmFinal;
            fixmystreetToConfirmFinal = [SELECT Confirm_Service_Code__c, Confirm_Subject_Code__c  FROM FixMyStreetToConfirm__c WHERE FieldValue__c= :secondFieldValue AND FixMyStreetCategories__c  = :cat LIMIT 1];
    		system.debug(fixmystreetToConfirmFinal);
            if (fixmystreetToConfirmFinal.size() == 0)
            {
                ConfirmServiceCode = 'C016';
                ConfirmSubjectCode = 'C054';
                system.debug('---no final match returned so using defaults----');
		        //sendEmailMessage('SALESFORCE - error on loading to Confirm - No Service Code Match', fixmystreetId, 'anix@rutland.gov.uk');
            }
            else
            {
                system.debug('---final match success----');
                FixMyStreetToConfirm__c fixmystreetCat = fixmystreetToConfirmFinal[0];
                system.debug(fixmystreetCat);
                if (fixmystreetCat.Confirm_Service_Code__c != null)
                { 
                    ConfirmServiceCode = fixmystreetCat.Confirm_Service_Code__c;
                }
                if (fixmystreetCat.Confirm_Subject_Code__c != null)
                { 
                    ConfirmSubjectCode = fixmystreetCat.Confirm_Subject_Code__c;
                }
            }
        }
        catch(System.Exception e)
        {
        // if we error then go for generic cacth all ServiceCode
        ConfirmServiceCode = 'C016';
        ConfirmSubjectCode = 'C054';
        system.debug('---Error during final match returned so using defaults----');
        logError = true;
        logEntry = logEntry + 'Error during final match returned so using defaults\r\n';
         }
        
       
        
        string fullDescription = '';
        string newline = '&#xD;';
        if (fixmystreet.title__c != null)
            {
            fullDescription = fullDescription + 'Summary:'+fixmystreet.title__c+newline;
            }
        if (fixmystreet.Description__c != null)
            {
	        fullDescription = fullDescription + 'Description:'+fixmystreet.Description__c+newline;
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


        string siteCode = 'RUTLAND';
        if (fixmystreet.SiteCode__c != null)
        {
            siteCode = fixmystreet.SiteCode__c;
        }
        system.debug(siteCode);

       string X = '';
        string Y = '';
          Double easting = 0;
          Double northing = 0;

        
        if (fixmystreet.Easting__c != null && fixmystreet.Northing__c != null)
        {
            X = String.valueOf(fixmystreet.Easting__c);
            Y = String.valueOf(fixmystreet.Northing__c);
        }
        else
        {
            //https://www.bgs.ac.uk/data/webservices/convertform.cfm
            string lat =   String.valueOf(fixmystreet.lat__c);
            string lng =   String.valueOf(fixmystreet.long__c);
            string url = 'https://www.bgs.ac.uk/data/webservices/CoordConvert_LL_BNG.cfc?method=LatLongToBNG&lat='+lat+'&lon='+lng;
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();
            req.setEndpoint(url);
            system.debug(url);
            req.setMethod('POST');
            req.setHeader('Content-Length','0');
         if(!Test.isRunningTest()) {
            // under  Test we cannot make web service call outs
               try 
               {
                    res = http.send(req);
                } catch(System.CalloutException e) {
                    System.debug('Callout error: '+ e);
                    System.debug(res.toString());
                }        
            }
            else
            {
                res.setHeader('Content-Type', 'application/json');
                res.setBody('{"DEGMINSECLNG":{"DEGREES":-1,"SECONDS":24,"MINUTES":32},"EASTING":451030.444044407,"LONGITUDE":-1.54,"ERROR":false,"DEGMINSECLAT":{"DEGREES":-5,"SECONDS":0,"MINUTES":33},"NORTHING":-6141064.83570885,"LATITUDE":-5.55} ');
                res.setStatusCode(200);
            } 
			
            system.debug('-----return from web call----');
            system.debug(res.getBody());
            try
                {
                Map<String, Object> m = (Map<String, object>) JSON.deserializeUntyped(res.getBody());
                // when the record is returned a unique payment reference is created
                easting = Double.valueOf(m.get('EASTING'));
                northing = Double.valueOf(m.get('NORTHING'));
                X = String.valueOf(easting);
                Y = String.valueOf(northing);
                }
            catch(System.Exception e)
                {
        		logError = true;
        		logEntry = logEntry + 'error on loading to Confirm - translate Easting Northing\r\n';                
                }
       // end of easting northing section
        }
    
        
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
        string location = '';
        if (fixmystreet.Location__c != null)
        {
            location = fixmystreet.Location__c;
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
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        system.debug('---ready to make confirm call----');
        
        DateTime now = DateTime.now();
        String unique = now.format('ddMMyyyyHHmm');
        
        string orgId = UserInfo.getOrganizationId();
        system.debug('OrgId: '+orgId);
        boolean production = true;
        if (orgId == '00D6E0000000aMfUAI')
        {
            production = false;
        }
        string ConfirmUrl;
        string ConfirmPassword;
        string ConfirmDatabaseId;
        
        if (production)
        {
            ConfirmUrl = 'https://connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx';
            ConfirmPassword = 'Enquiri3s';
            ConfirmDatabaseId = 'Rutland County Council and Tarmac - Production';
        }
        else
        {
            ConfirmUrl = 'https://development-connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx';
            ConfirmPassword = 'Enquir1es';
            ConfirmDatabaseId = 'Rutland County Council and Tarmac - Development';
        }
        
        
            
        
        
        string body = '<?xml version="1.0" encoding="utf-8"?>';
        body = body + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
		body = body + '<soap12:Body>';
		body = body + '<ProcessOperationsRequest xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
		body = body + '<Request xmlns="">';
		body = body + '<Authentication>';
		body = body + '<Username>SFCRM</Username>';
		body = body + '<Password>'+ConfirmPassword+'</Password>';
		body = body + '<DatabaseId>'+ConfirmDatabaseId+'</DatabaseId>';
		body = body + '</Authentication>';
		body = body + '<Operation>';
		body = body + '<NewEnquiry>';
        body = body + '<EnquiryNumber>1</EnquiryNumber>';
        body = body + '<ServiceCode>'+ConfirmServiceCode+'</ServiceCode>';
        body = body + '<SubjectCode>'+ConfirmSubjectCode+'</SubjectCode>';
        body = body + '<EnquiryDescription>'+fullDescription+'</EnquiryDescription>';
        body = body + '<EnquiryLocation>'+location+'</EnquiryLocation>';
        body = body + '<LoggedTime>'+enquiryLogTime+'</LoggedTime>';
        body = body + '<EnquiryX>'+X+'</EnquiryX>';
        body = body + '<EnquiryY>'+Y+'</EnquiryY>';
        body = body + '<SiteCode>'+siteCode+'</SiteCode>';
        body = body + '<ExternalSystemReference>'+crmRef+'_'+unique+'</ExternalSystemReference>';
        body = body + '<ExternalSystemNumber>1</ExternalSystemNumber>';
        body = body + '<EnquiryCustomer>';
        body = body + '<CustomerSurname>'+custSurname+'</CustomerSurname>';        
        body = body + '<CustomerPhone>'+custPhone+'</CustomerPhone>';
        body = body + '<CustomerEmail>'+custEmail+'</CustomerEmail>';
        body = body + '<PointOfContactCode>B005</PointOfContactCode>';
        body = body + '<EnquiryMethodCode>B007</EnquiryMethodCode>';
        body = body + '<CustomerTypeCode>B001</CustomerTypeCode>';
        body = body + '</EnquiryCustomer>';
        body = body + '</NewEnquiry>';
		body = body + '</Operation>';
		body = body + '</Request>';
		body = body + '</ProcessOperationsRequest>';
		body = body + '</soap12:Body>';
		body = body + '</soap12:Envelope>';
        
        System.debug(body);
         //sendEmailMessage('SALESFORCE - Debug on loading to Confirm - body', body, 'anix@rutland.gov.uk');
       logEntry = logEntry + body+'\r\n';                
       
        
        req.setEndpoint(ConfirmUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('Charset', 'UTF-8');
		req.setTimeout(20000);
        req.setBody(body);
        //req.setCompressed(true);
        
       

        if(!Test.isRunningTest()) {
            // under  Test we cannot make web service call outs
            try {
                res = http.send(req);
            } catch(System.CalloutException e) {
                system.debug('---ERROR CALLING----');
                System.debug('Callout error: '+ e);
                System.debug(res.toString());
                system.debug('-------');
        		logError = true;
        		logEntry = logEntry + 'callout error on loading to Confirm\r\n';
				logEntry = logEntry + res.toString();                
            }
        }
        else
        {
         	res.setHeader('Content-Type', 'application/json');
        	res.setBody('XMLBODY <EnquiryNumber>TEST</EnquiryNumber>');
        	res.setStatusCode(200);
		}   
        system.debug('---MESSAGE FROM CONFIRM ----');
        System.debug(res.getBody());
		logEntry = logEntry + res.getBody()+'\r\n';
            system.debug('----END OF MESSAGE FROM CONFIRM---');

        
        //see if we can find <EnquiryNumber>11000120</EnquiryNumber> and extract the number
        string result = res.getBody();
       
        
        string enquiryNumber = 'Error';
        integer findstart = result.indexOf('<EnquiryNumber>');
        integer findend = result.indexOf('</EnquiryNumber>');
        if (findstart>0 && findend>findstart)
        {
            integer len  = findend - findstart - 15;
            if (len>0)
            {
                enquiryNumber = result.mid(findstart + 15,len);
            }
        }
        system.debug(enquiryNumber);
        // update enquiryNumber
        fixmystreet.ConfirmReference__c = enquiryNumber;

        if (enquiryNumber == 'Error')
        {
        		logError = true;
        		logEntry = logEntry + 'Error on loading to Confirm\r\n';
        }


        
		// if no sitecode
        if (fixmystreet.SiteCode__c == null)
        {
            fixmystreet.SiteCode__c  = 'RUTLAND';
        }
        
        
        // if no easting then need to upload
        if (fixmystreet.Easting__c == null)
        {
            fixmystreet.Easting__c =  easting;
            fixmystreet.Northing__c =  northing;
        }
		upsert fixmystreet;                               
        
       if (logError)
      {
          ConfirmLogEntry(logEntry);
      }
        
    //    Dom.Document doc = res.getBodyDocument();
    //    System.debug('Dom.Document ====>');
    //    System.debug(doc);
    //    Dom.XMLNode node = doc.getRootElement();
    //    System.debug('node ====>');
    //    System.debug(node);
    }

    /*
    @future (callout=true)
    public static void ConfirmUpdates() {


        system.debug('Collecting updates from Confirm');


        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        
        string body = '<?xml version="1.0" encoding="utf-8"?>';
        body = body + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
		body = body + '<soap12:Body>';
		body = body + '<ProcessOperationsRequest xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
		body = body + '<Request xmlns="">';
		body = body + '<Authentication>';
		body = body + '<Username>SFCRM</Username>';
		body = body + '<Password>Enquir1es</Password>';
		body = body + '<DatabaseId>Rutland County Council and Tarmac - Development</DatabaseId>';
		body = body + '</Authentication>';
		body = body + '<Operation>';
		body = body + '<GetNewEnquiryStatusChanges/>';
		body = body + '</Operation>';
		body = body + '</Request>';
		body = body + '</ProcessOperationsRequest>';
		body = body + '</soap12:Body>';
		body = body + '</soap12:Envelope>';
        
        System.debug(body);
        
        
        req.setEndpoint('https://development-connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('Charset', 'UTF-8');
		req.setTimeout(20000);
        req.setBody(body);
        //req.setCompressed(true);
        
        

        if(!Test.isRunningTest()) {
            // under  Test we cannot make web service call outs
            try {
                res = http.send(req);
            } catch(System.CalloutException e) {
                system.debug('---ERROR CALLING----');
                System.debug('Callout error: '+ e);
                System.debug(res.toString());
                system.debug('-------');
            }
        }
        else
        {
         	res.setHeader('Content-Type', 'application/json');
        	res.setBody('XMLBODY <EnquiryNumber>TEST</EnquiryNumber>');
        	res.setStatusCode(200);
		}   
        
        //string result = res.getBody();
        
        string result;
        
        result = result + '<?xml version="1.0" encoding="utf-8"?>';
result = result + '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
    result = result + '<soap:Body>';
        result = result + '<ProcessOperationsResult xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
            result = result + '<Response SchemaVersion="1.4" xmlns="">';
                result = result + '<OperationResponse>';
                    result = result + '<GetNewEnquiryStatusChangesResponse>';
                        result = result + '<UpdatedEnquiry>';
                            result = result + '<EnquiryNumber>11000155</EnquiryNumber>';
                            result = result + '<ExternalSystemNumber>1</ExternalSystemNumber>';
                            result = result + '<ExternalSystemReference>FMS-RCC-00276_061220181233</ExternalSystemReference>';
                            result = result + '<EnquiryX>486532.17</EnquiryX>';
                            result = result + '<EnquiryY>309943.66</EnquiryY>';
                            result = result + '<EnquiryStatusLog>';
                                result = result + '<EnquiryLogNumber>2</EnquiryLogNumber>';
                                result = result + '<EnquiryStatusCode>2800</EnquiryStatusCode>';
                                result = result + '<EnquiryStatusName>Defect Found: 7 Day Priority</EnquiryStatusName>';
                                result = result + '<AssignedOfficerCode>CUSE</AssignedOfficerCode>';
                                result = result + '<AssignedOfficerName>Customer Services Default</AssignedOfficerName>';
                                result = result + '<LoggedTime>2018-12-07T15:11:52</LoggedTime>';
                                result = result + '<LogEffectiveTime>2018-12-07T15:11:48</LogEffectiveTime>';
                                result = result + '<StatusFollowUpTime>2018-12-08T15:11:48</StatusFollowUpTime>';
                                result = result + '<LoggedByUserName>Andy Nix</LoggedByUserName>';
                                result = result + '<LoggedByUserId>RUTAR00030</LoggedByUserId>';
                            result = result + '</EnquiryStatusLog>';
                        result = result + '</UpdatedEnquiry>';
                    result = result + '</GetNewEnquiryStatusChangesResponse>';
                result = result + '</OperationResponse>';
            result = result + '</Response>';
        result = result + '</ProcessOperationsResult>';
    result = result + '</soap:Body>';
result = result + '</soap:Envelope>';
        
        
        result = result.replace('<GetNewEnquiryStatusChangesResponse />', '<GetNewEnquiryStatusChangesResponse/>');
        
        integer start = result.indexOf('<OperationResponse>');
        integer finish = result.indexOf('</OperationResponse>') + 20;
        
        
        result = result.mid(start, finish-start);
        
        system.debug('---MESSAGE FROM CONFIRM ----');
        System.debug(result);
        system.debug('----END OF MESSAGE FROM CONFIRM---');

        //XmlStreamReader xsr = new XmlStreamReader(res.getBody());
        //system.debug(xsr);
        //XmlStreamReader xsr1 = new XmlStreamReader(result);
        //system.debug(xsr1);

        DOM.Document doc=new DOM.Document();
        doc.load(result);
 
		sendEmailMessage('SALESFORCE - error on loading to Confirm', result, 'anix@rutland.gov.uk');

        

        DOM.XmlNode rootNode=doc.getRootElement();
        
        for (Dom.XMLNode child : rootNode.getChildElements()) {
            system.debug(child.getName());
            if (child.getName() == 'GetNewEnquiryStatusChangesResponse')
            {
	        for (Dom.XMLNode lowerChild : child.getChildElements()) 
            	{
                    system.debug(lowerChild.getName());
                    Dom.XMLNode enquiry = lowerChild.getChildElement('EnquiryNumber',null);
                    if (enquiry != null)
                    	{
                        system.debug(enquiry);
                    	system.debug(enquiry.getText());
                        UpdateFixMyStreet(enquiry.getText(),lowerChild);
                        }
            	}
            }
        }
        
        system.debug(doc);
        
        //Map<String, Object> m = (Map<String, object>) JSON.deserializeUntyped(result);
        
        //System.debug(m);
        
    //    Dom.Document doc = res.getBodyDocument();
    //    System.debug('Dom.Document ====>');
    //    System.debug(doc);
    //    Dom.XMLNode node = doc.getRootElement();
    //    System.debug('node ====>');
    //    System.debug(node);
    }

    public static  void UpdateFixMyStreet(string enquiry,Dom.XMLNode lowerChild)
    {
        
       	FixMyStreet__c fixmystreet;
        fixmystreet = [SELECT id, Name, Service_Area__c,title__c,
                       ConfirmReference__c, New_update_Comments__c, Update_FixMyStreet__c 
                        FROM FixMyStreet__c 
                        WHERE ConfirmReference__c = :enquiry
                        LIMIT 1
                       ];

        system.debug(fixmystreet);
        if (fixmystreet != null)
        {
            Dom.XMLNode enquiryStatusLog = lowerChild.getChildElement('EnquiryStatusLog',null);
            if (enquiryStatusLog != null)
            {
	            Dom.XMLNode enquiryStatusCode = enquiryStatusLog.getChildElement('EnquiryStatusCode',null);
                system.debug(enquiryStatusCode.getText());
                string code = enquiryStatusCode.getText();
                FixMyStreet_Updates__mdt fms_Update;
                fms_Update = [SELECT MasterLabel, Update_Text__c, Closed__c  FROM FixMyStreet_Updates__mdt WHERE MasterLabel = :code LIMIT 1];
                string newComments = fms_Update.Update_Text__c;
                system.debug(newComments);
                fixmystreet.New_update_Comments__c = newComments;
                fixmystreet.Update_FixMyStreet__c = true;
                if (fms_Update.Closed__c == true)
                {
                    fixmystreet.Status__c = 'Closed';
                }
                upsert fixmystreet;
            }
        }
        
    }
    

  public static void sendEmailMessage(string subject, string message, string email) {
        
        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
        emailMessage.toAddresses = new String[] { email };
        emailMessage.optOutPolicy = 'FILTER';
        emailMessage.subject = subject;
        emailMessage.htmlbody = message;
        
        try
        {
            Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {emailMessage};
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            }
        } catch(System.CalloutException e) {
            System.debug('Sending Email Error: '+ e);
        }
        
    }
*/    
 
    // run ConfirmWebService.testMe(); from Execute Anonymous to test
    //public static  void testMe() {
    //    sendGetEnquiryLookups();
    //}
    //public static  void testMe1() {
    //    GetEnquiryLookups('11000091');
    //}
    //public static  void testMe2() {
//		NewEnquiry();
  //  }
    
    
}