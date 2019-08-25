@isTest
public class ConfirmWebService_Test {
 

    
    @isTest
    static void tests() {
        
             // create a case
        FixMyStreetCategories__c fixmystCat = new FixMyStreetCategories__c(
			service_code__c = 'RC01'
            );
		insert fixmystCat;
        
      //SELECT service_code__c FROM FixMyStreetCategories__c where Live__C=true and Id=:FixMyStreetId
      Object res  =  ConfirmWebService.GetFixMyStreetExtends(fixmystCat.Id);
 
        
        
       FixMyStreetCategories__c fixmystCat1 = new FixMyStreetCategories__c(
			service_code__c = 'RC01',
            Send_to_Confirm__c = true
            );
		insert fixmystCat1;
          
      Object res1  =  ConfirmWebService.GetFixMyStreetExtends(fixmystCat1.Id);
        
        
     
     
FixMyStreetToConfirm__c fixmyConfirmObj = new   FixMyStreetToConfirm__c(
	FixMyStreetCategories__c = fixmystCat1.Id,
    SecondField__c = 'Extends_RC01_Highways_Defects__c'
);                      
		insert fixmyConfirmObj;
     
     // create a case
        FixMyStreet__c fixmyObj = new FixMyStreet__c(
          Service_Area__c = fixmystCat1.Id,
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
            requested_datetime__c = DateTime.now()
        );
		insert fixmyObj;
        
        ConfirmWebService.NewConfirmEnquiryFromId(fixmyObj.Id, false);
        ConfirmWebService.NewConfirmEnquiryFromId(fixmyObj.Id, true);


     // create a case
        FixMyStreet__c fixmyObj1 = new FixMyStreet__c(
          Service_Area__c = fixmystCat1.Id,
          title__c = 'test'  ,
          Description__c = 'test',

          Contact_Name__c = 'test',
          Contact_Phone__c = 'test',
          Contact_Email__c = 'test@test.com',
          lat__c = 1.1, 
          long__c = 1.1,
           Location__c = 'test', 
            ConfirmReference__c = '',
            Extends_RC01_Highways_Defects__c = 'Pothole',
            requested_datetime__c = DateTime.now()
        );
		insert fixmyObj1;
        
        ConfirmWebService.NewConfirmEnquiryFromId(fixmyObj1.Id,false);
        ConfirmWebService.NewConfirmEnquiryFromId(fixmyObj1.Id,true);
        

    }
}