@istest
public class FixMyStreetTestUpdates {

      static testMethod void  testgetFixMyStreetUpdates(){
   
         
   Test.startTest();
   
      // create a case
        FixMyStreetCategories__c fixmystCat = new FixMyStreetCategories__c(
			service_code__c = 'RC01'
            );
		insert fixmystCat;


      FixMyStreet__c fixmyObj = new FixMyStreet__c(
          Service_Area__c = fixmystCat.Id,
          title__c = 'test'  ,
          Description__c = 'test',
          Easting__c = 123, 
          Northing__c = 123,
          Contact_Name__c = 'test',
          Contact_Phone__c = 'test',
          Contact_Email__c = 'test@test.com',
          lat__c = 1.1, 
          long__c = 1.1,
           Location__c = 'test', 
            SiteCode__c = '123',
            ConfirmReference__c = '',
            Extends_RC01_Highways_Defects__c = 'Pothole',
            Status__c = 'Closed',
            requested_datetime__c = DateTime.now(),
          New_update_Comments__c = 'Comment',
          Update_FixMyStreet__c = true
        );
		insert fixmyObj;

   

   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreetUpdates';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('updates', 'yes');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


    FixMyStreetUpdates.getFixMyStreetUpdates(); //Call the Method of the Class with Proper       Constructor 
   
     // System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
   }
    
   static testMethod void  testgetFixMyStreetUpdatesTest(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreetUpdates';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('test', 'yes');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


    FixMyStreetUpdates.getFixMyStreetUpdates(); //Call the Method of the Class with Proper       Constructor 
   
     // System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
   }
}