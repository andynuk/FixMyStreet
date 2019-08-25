@RestResource(urlMapping='/FixMyStreetUpdates/*')
global with sharing class FixMyStreetUpdates {

    public class Parent {
    public String id;
    public String Comments;
    public String Status;
	}

    
    @HttpGet
    global static void getFixMyStreetUpdates() {
        RestRequest request = RestContext.request;
               
        RestRequest req = RestContext.request;
        String p_updates = req.params.get('updates');
        String p_test = req.params.get('test');

 		Parent[] listResults = new Parent[] {};
 
        if (p_updates != null) {
		 		List<FixMyStreet__c> resultList =  database.query('SELECT Id,New_update_Comments__c,Update_Comments__c,status__c FROM FixMyStreet__c where Update_FixMyStreet__c=true');
             	for (FixMyStreet__c indResult: resultList) {
                    Parent p = new Parent();
                    p.id = indResult.id;
                    p.Comments = indResult.New_update_Comments__c;
                    p.Status = indResult.status__c;
            		listResults.add(p);
                    if (indResult.New_update_Comments__c != null && p_test != 'true') {
                        FixMyStreet_Comments__c newcomment = new FixMyStreet_Comments__c(
                            Comment__c = indResult.New_update_Comments__c, 
                            Comment_Id__c = 'Internal Comment',
                            Comment_Date__c = datetime.now(),
                            FixMyStreet__c= indResult.id);
                            insert newcomment;   
                         }
                    // now update clear the comments
                    indResult.New_update_Comments__c = '';
                    indResult.Update_FixMyStreet__c = false;
                    upsert indResult;
                    }       
       		 }

		string result = JSON.serializePretty(listResults);     
        RestContext.response.addHeader('Content-Type', 'application/json');
		RestContext.response.responseBody = Blob.valueOf(result);
        
        // use this updates from FixMyStreet to capture any updates from Confirm for FixMyStreet (next call)
		ConfirmUpdate.ConfirmUpdates();
        
    }


}