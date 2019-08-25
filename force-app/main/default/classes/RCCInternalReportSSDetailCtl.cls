public class RCCInternalReportSSDetailCtl {

    
    public class Child {
    public String name;
    public String label;
    public String fieldType;
    public String length;
    public String[] optionsList = new String[] {};
	}
    
    @AuraEnabled
    public static string GetFixMyStreetExtends(string FixMyStreetId) {
       
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

        
        string result  = JSON.serializePretty(resultList); 
        return result;
        //return resultList;
       }

        
     @AuraEnabled
    public static string createNewFixMyStreet(string newRecord) {

      
        FixMyStreet__c fixmystreet = (FixMyStreet__c) JSON.deserialize(newRecord, FixMyStreet__c.class);
        
        system.debug(fixmystreet);
        
        fixmystreet.agency_responsible__c  = 'Rutland County Council';
        fixmystreet.interface_used__c = 'CST';
        fixmystreet.requested_datetime__c = Datetime.now();
        
		// need to populate easting and northing
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
        
        
        if(!Test.isRunningTest()) {
           // under  Test we cannot make web service call outs
            try {
                    res = http.send(req);
                } catch(System.CalloutException e) {
                    System.debug('Callout error: '+ e);
                    System.debug(res.toString());
                }        
        	}
           else
           {
         	res.setHeader('Content-Type', 'application/json');
        	res.setBody('{"EASTING":"1", "NORTHING":"1"}');
        	res.setStatusCode(200);
			}        
        System.debug(res.getBody());
        
        try {
        Map<String, Object> m = (Map<String, object>) JSON.deserializeUntyped(res.getBody());
        //System.debug('------');
        //System.debug(m);
        //System.debug('------');
        //System.debug(m.keySet());
        //System.debug(m.get('EASTING'));
        //System.debug(m.get('NORTHING'));
        // when the record is returned a unique payment reference is created
        Double easting = Double.valueOf(m.get('EASTING'));
        Double northing = Double.valueOf(m.get('NORTHING'));
        //System.debug(easting);
        //System.debug(northing);
        fixmystreet.Easting__c =  easting;
        fixmystreet.Northing__c =  northing;
        }
        catch (Exception e)
        {}
	

        insert fixmystreet;

		string newId = fixmystreet.Id;
		// try and get the entry back after uploading 
		List<FixMyStreet__c> searchFixMyStreet;
        searchFixMyStreet = [SELECT id FROM FixMyStreet__c Where Id =: newId LIMIT 1];
        
        string result = 'Error';
        if (searchFixMyStreet!=null)
        {
            result = newId;
        }
        return result;
    }

    @AuraEnabled
    public static List<FixMyStreet__c> GetStreetSceneHistory (Id ServiceArea) {
        List<FixMyStreet__c> streetsceneHistory;
        //streetsceneHistory = [SELECT id, Name, requested_datetime__c,Location__c,Status__c,Service_Area__c, Case__r.CreatedDate FROM FixMyStreet__c WHERE Service_Area__c =: ServiceArea order by Case__r.CreatedDate DESC LIMIT 5];
        //streetsceneHistory = [SELECT id, Name,Location__c,Status__c,Service_Area__c, Case__r.CreatedDate FROM FixMyStreet__c WHERE Service_Area__c =: ServiceArea ORDER BY Case__r.CreatedDate DESC LIMIT 10];
        streetsceneHistory = [SELECT id, Name, lat__c, long__c, Update_Comments__c, requested_datetime__c,Location__c,Status__c,Service_Area__c,Service_Area__r.Name, Case__r.CreatedDate FROM FixMyStreet__c where Service_area__c =: ServiceArea AND requested_datetime__c!=null order by requested_datetime__c DESC LIMIT 15];
        return streetsceneHistory;
    }
}