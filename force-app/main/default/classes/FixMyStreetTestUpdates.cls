@istest(SeeAllData=true)
public class FixMyStreetTestUpdates {

      static testMethod void  testgetFixMyStreetUpdates(){
   
         
   Test.startTest();
   
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