@RestResource(urlMapping='/FixMyStreet/*')
global with sharing class FixMyStreetManager {

    @HttpGet
    global static List<FixMyStreet__c> getFixMyStreet() {
        RestRequest request = RestContext.request;
        
        List<FixMyStreet__c> result = null;
 
 		//get object fields
        List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap().keySet());
        String fields = String.join(fieldList,',');       
        
        RestRequest req = RestContext.request;
        String p_id = req.params.get('id');
        String p_del = req.params.get('del');
        String p_delall = req.params.get('delall');
        String p_all = req.params.get('all');
        String p_name = req.params.get('name');

       
        if (p_id != null) {
 		 		//result =  database.query('SELECT title__c,agency_sent_datetime__c,agency_responsible__c,description__c,detail__c,interface_used__c,lat__c,long__c,requested_datetime__c,requestor_name__c,service_code__c,service_name__c,service_request_id__c,status__c,updated_datetime__c FROM FixMyStreet__c where Id = :p_id');
 		 		result =  database.query('SELECT '+fields+' FROM FixMyStreet__c where Id = :p_id');
        } else if (p_name != null) {
 		 		result =  database.query('SELECT '+fields+' FROM FixMyStreet__c where name = :p_name');
        } 
        else if (p_all != null) {
 		 		result =  database.query('SELECT '+fields+' FROM FixMyStreet__c');
        } else if (p_del != null) {
 		 	result =  database.query('SELECT Id FROM FixMyStreet__c where Id = :p_del');
            delete result;
        }
        else if (p_delall != null) {
           if (p_delall == 'Confirm')
            {
 		 	result =  database.query('SELECT Id FROM FixMyStreet__c');
            delete result;
            }    
        }
        
        return result;
    }

    global class FixMyStreet{
        public String title;
    }
    
    @HttpPost
    global static void createFixMyStreet()
    {
        //get object fields
        List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap().keySet());
        String fields = String.join(fieldList,',');   
        //fields = fields.toLowerCase();
           
        
		string result = '';
        List<Id> retid = new List<Id>();
        
        string body = RestContext.request.requestBody.toString();
        //body = body.toLowerCase();
        
        List<Object> requestList = (List<Object>) JSON.deserializeUntyped(body);
        
        for (Object requestObject : requestList)
        {
        Map<String, Object> m =  (Map<String, Object>) requestObject;        

        
        
      	if (m.get('Id') != null || m.get('id') != null)
            {
                //do updated not insert
                string fixId = '';
                if (m.get('Id') != null)
            		{
                    fixId = (string) m.get('Id');
                    }
                else
                    {
                    fixId = (string) m.get('id');
                    }
                system.debug('Updating id: '+fixID);
				system.debug('Status__c: ' +m.get('status__c'));
                system.debug('Making call to look up entry to update');
                
                List<FixMyStreet__c> fixs =  database.query('SELECT status__c, Update_Comments__c FROM FixMyStreet__c where Id = :fixId');
 				// check if results
            	FixMyStreet__c fix = null;
                if (fixs.size()>0)
                {
                    fix = fixs[0];
                    system.debug('Updating entry');
                    system.debug(fix);
                    
                    if (m.get('status__c') != null)
                    {
                        fix.status__c = (string) m.get('status__c');
                        upsert fix;
                    }   
                    retid.add(fix.Id);
                    // add new comment to related comments list
                    if (m.get('update_comments__c') != null)
                    {
                        FixMyStreet_Comments__c newcomment = new FixMyStreet_Comments__c(
                            Comment__c = (string) m.get('update_comments__c'), 
                            Comment_Id__c = (string) m.get('update_comments_id__c'),
                            Comment_Date__c = datetime.now(),
                            FixMyStreet__c=fixId);
                        insert newcomment;           
                    }
                    // end of update   
                }
            }
       		else
       		{
			// new entry
            FixMyStreet__c fix = new FixMyStreet__c();
            // iterate through the fields on the main record to match to the incoming JSON
            // default status to Open
            fix.Status__c = 'Open';
            for (string field : fieldList)
            {
             //   system.debug(field);
             //   system.debug(m.get(field));
                if(m.get(field) != null){
                    if (field == 'requested_datetime__c' || field == 'updated_datetime__c' || field == 'agency_sent_datetime__c')
                        {
                        string fieldst = (string) m.get(field);
                        DateTime dt = (DateTime) JSON.deserialize('"' + fieldst + '"', DateTime.class);
                        fix.put(field, dt);
                        }
                    else
                        {
                        fix.put(field, m.get(field));
                        }
                    }
            }
   
            // the Service_Area__c needs matching
            string serv = (string) m.get('Service_Area__c');
                system.debug(serv);
            //FixMyStreetCategories__c service = database.query('select Id from FixMyStreetCategories__c where Id= :serv');
              //  system.debug(service);
            //fix.Service_Area__c  = service.Id;
            fix.Service_Area__c  = serv;
           // system.debug(fix);

                // add a standard comment response to go back...next time
                string code = '1000';
                //FixMyStreet_Updates__mdt fms_Update;
                List<FixMyStreet_Updates__mdt> fms_Updates = [SELECT MasterLabel, Update_Text__c  FROM FixMyStreet_Updates__mdt WHERE MasterLabel = :code LIMIT 1];
                if (fms_Updates.size() == 1)
                	{
                	string newComments = fms_Updates[0].Update_Text__c;
                	system.debug(newComments);
                	fix.New_update_Comments__c = newComments;
                	fix.Update_FixMyStreet__c = true;
                	fix.Status__c = 'Investigating';
                    }
                
            insert fix;
            // photos need importing
                
			if (m.get('photos') != null)
                {
	 			List<Object> urls =  (List<Object>) m.get('photos'); 
    	        for (Object a: urls)
	        	    {
    	        	string photourl = (string) a;
                        FixMyStreet_Photo__c newphoto = new FixMyStreet_Photo__c();
                        //newphoto.Name = (string) mphoto.get('Name');
                        newphoto.Photo_Link__c = photourl;
                        newphoto.FixMyStreet__c = fix.Id;
                        //system.debug(newphoto);    
                        insert newphoto;
        	    	}
                }
                
             retid.add(fix.Id);
            }
            
            
        }

        
        
        
        List<FixMyStreet__c> retList = new List<FixMyStreet__c>();
      	retList =  database.query('SELECT '+fields+' FROM FixMyStreet__c where Id = :retid');
        result = JSON.serializePretty(retList);

   
		RestContext.response.addHeader('Content-Type', 'application/json');
		RestContext.response.responseBody = Blob.valueOf(result);
    } 
    
    /*
    //@HttpPost
    global static List<FixMyStreet__c> createFixMyStreetOLD()
    {
        String requestBody = RestContext.request.requestBody.toString();
        
        List<FixMyStreet__c> fixList = (List<FixMyStreet__c>) JSON.deserialize(requestBody, List<FixMyStreet__c>.class);
        
        List<FixMyStreet__c> retList = new List<FixMyStreet__c>();
        List<Id> retid = new List<Id>();
        
        for (FixMyStreet__c fix : fixList)
        {
        	if (fix.Id != null)
            {
                //do updated not insert
                string fixId = fix.Id;
             	FixMyStreet__c result =  database.query('SELECT status__c, Update_Comments__c FROM FixMyStreet__c where Id = :fixId');
                result.status__c = fix.status__c;
                result.Update_Comments__c = fix.Update_Comments__c;
                upsert result;
                // add new comment to related comments list
                FixMyStreet_Comments__c newcomment = new FixMyStreet_Comments__c(
                    	Comment__c = fix.Update_Comments__c, 
                    	Comment_Id__c = fix.Update_Comments_Id__c,
                    	Comment_Date__c = datetime.now(),
                    	FixMyStreet__c=fixId);
                insert newcomment;                
            }
            else                
            {
                // new record
            insert fix;
            }
            retid.add(fix.Id);
        }
        
    	//get object fields
        List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap().keySet());
        String fields = String.join(fieldList,',');       
       
    	retList =  database.query('SELECT '+fields+' FROM FixMyStreet__c where Id = :retid');
     
        return retList;
    }    
*/
    
}