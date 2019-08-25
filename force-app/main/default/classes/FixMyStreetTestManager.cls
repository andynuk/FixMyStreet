@istest(SeeAllData=true)
public class FixMyStreetTestManager {
 
   static testMethod void  testgetFixMyStreet_All(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('all', 'yes');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


   List<FixMyStreet__c> result = FixMyStreetManager.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
      System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }
    
   static testMethod void  testgetFixMyStreet_id(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('id', 'yes');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


   List<FixMyStreet__c> result = FixMyStreetManager.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
      System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }

   static testMethod void  testgetFixMyStreet_name(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('name', 'yes');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


   List<FixMyStreet__c> result = FixMyStreetManager.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
      System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }
    
   static testMethod void  testgetFixMyStreet_del(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('del', 'yes');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


   List<FixMyStreet__c> result = FixMyStreetManager.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
      System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }
    
   static testMethod void  testgetFixMyStreet_dellall(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'GET';//HTTP Request Type
   req.addParameter('delall', 'confirm');
   //req.requestBody = Blob.valueof(JsonMsg);
   RestContext.request = req;
   RestContext.response= res;


   List<FixMyStreet__c> result = FixMyStreetManager.getFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
   
      System.debug(result);
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }    
    
   
   static testMethod void  testcreateFixMyStreet(){
   
         
   Test.startTest();
       
    FixMyStreetCategories__c  tempService = new FixMyStreetCategories__c (
        	Name = 'Test Service',
    		Service_Code__c = 'Temp',
        	Send_to_Confirm__c = false
    );
    insert tempService;
   
        
       //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
  List<string> photolist = new List<string>();
       photolist.add('1');
       photolist.add('2');

            
    JSONGenerator generator = JSON.createGenerator(true); 	
    generator.writeStartObject(); 				
    generator.writeStringField('agency_responsible__c', 'Rutland County Council');  	 
    generator.writeStringField('description__c', 'Test');  	
    generator.writeStringField('detail__c', 'Test');  	
    generator.writeStringField('Service_Area__c', tempService.Id);  	
   // generator.writeStringField('id', 'a086E000001yIG0QAM');
    generator.writeStringField('status__c', 'open');  	
    generator.writeStringField('update_comments__c','test');
    generator.writeStringField('requested_datetime__c', '2017-12-08T09:47:35.000+0000');

    generator.writeObjectField ('photos', photolist);

  
    generator.writeEndObject(); 				
    String jsonString = generator.getAsString();  
    jsonString = '[' + jsonString + ']';   
    system.debug(jsonString);   
  
       
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'POST';//HTTP Request Type
   req.requestBody = Blob.valueof(jsonString);
   RestContext.request = req;
   RestContext.response= res;


   FixMyStreetManager.createFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }
    


  static testMethod void  testcreateFixMyStreetUpdate(){
   
         
   Test.startTest();
   
    FixMyStreetCategories__c  tempService = new FixMyStreetCategories__c (
        	Name = 'Test Service',
    		Service_Code__c = 'Temp',
        	Send_to_Confirm__c = false
    );
    insert tempService;
      
     
    // create a service requets to update
    FixMyStreet__c  tempFixMyStreet = new FixMyStreet__c (
        	title__c = 'Test Service',
    		Service_Area__c = tempService.Id
    );
    insert tempFixMyStreet;    
     
     //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
 

            
    JSONGenerator generator = JSON.createGenerator(true); 	
    generator.writeStartObject(); 				
    generator.writeStringField('agency_responsible__c', 'Rutland County Council');  	 
    generator.writeStringField('description__c', 'Test');  	
    generator.writeStringField('detail__c', 'Test');  	
    //generator.writeStringField('Service_Area__c', 'a096E000007q6HzQAI');  	
    generator.writeStringField('id', tempFixMyStreet.Id);
    generator.writeStringField('status__c', 'open');  	
    generator.writeStringField('update_comments__c','test');
    generator.writeStringField('requested_datetime__c', '2017-12-08T09:47:35.000+0000');
    generator.writeFieldName('photos');
    generator.writeStartObject();
    generator.writeStringField('photourl', 'photurl');
    generator.writeEndObject();
  
    generator.writeEndObject(); 				
    String jsonString = generator.getAsString();  
    jsonString = '[' + jsonString + ']';   
    system.debug(jsonString);   
       
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'POST';//HTTP Request Type
   req.requestBody = Blob.valueof(jsonString);
   RestContext.request = req;
   RestContext.response= res;


   FixMyStreetManager.createFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }        
    
     static testMethod void  testcreateFixMyStreetUpdateID(){
   
         
   Test.startTest();
   
   //As Per Best Practice it is important to instantiate the Rest Context 
   
   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();
         
 

            
    JSONGenerator generator = JSON.createGenerator(true); 	
    generator.writeStartObject(); 				
    generator.writeStringField('agency_responsible__c', 'Rutland County Council');  	 
    generator.writeStringField('description__c', 'Test');  	
    generator.writeStringField('detail__c', 'Test');  	
    generator.writeStringField('Service_Area__c', 'a096E000007q6HzQAI');  	
    generator.writeStringField('Id', 'a086E000001yIG0QAM');
    generator.writeStringField('status__c', 'open');  	
    generator.writeStringField('update_comments__c','test');
    generator.writeStringField('requested_datetime__c', '2017-12-08T09:47:35.000+0000');
    generator.writeFieldName('photos');
    generator.writeStartObject();
    generator.writeStringField('photourl', 'photurl');
    generator.writeEndObject();
  
    generator.writeEndObject(); 				
    String jsonString = generator.getAsString();  
    jsonString = '[' + jsonString + ']';   
    system.debug(jsonString);   
       
   req.requestURI = '/services/apexrest/FixMyStreet';  //Request URL
   req.httpMethod = 'POST';//HTTP Request Type
   req.requestBody = Blob.valueof(jsonString);
   RestContext.request = req;
   RestContext.response= res;


   FixMyStreetManager.createFixMyStreet(); //Call the Method of the Class with Proper       Constructor 
       
   //System.assert(resp.statusMessage.contains('Test success message'));//Assert the response has message as expected 
   //System.assert(resp.statusCode.contains('Done'));
   //System.assert(resp.acct.Id!=null);//Assert that the Account is inserted and has Id
   Test.stopTest();
  
   }


 }