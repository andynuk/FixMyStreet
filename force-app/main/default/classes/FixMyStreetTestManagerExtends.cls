@istest(SeeAllData=true)
public class FixMyStreetTestManagerExtends {
 
   static testMethod void  testgetFixMyStreetSummary(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreetInfo';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('summary', 'yes');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


    FixMyStreetExtends.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
     // System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
   }
  
    static testMethod void  testgetFixMyStreetName(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreetInfo';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('name_code', 'RC11');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


    FixMyStreetExtends.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
     // System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
   }
    
    /*
    static testMethod void  testgetFixMyStreetId(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreetInfo';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('id','a096E000007pbwjQAA');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


    FixMyStreetExtends.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
     // System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
   }
    */
   }