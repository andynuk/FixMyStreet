@isTest
public class FixMyStreetCreateCase_Test {
 
    @isTest
    static void tests() {
        
             // create a case
        FixMyStreetCategories__c fixmystCat = new FixMyStreetCategories__c(
			service_code__c = 'RC17',
            name = 'Fly Tipping'
            );
		insert fixmystCat;
        
      //SELECT service_code__c FROM FixMyStreetCategories__c where Live__C=true and Id=:FixMyStreetId
      Object res  =  FixMyStreetCreateCase.GetFixMyStreetExtends(fixmystCat.Id);
 
        
        
       FixMyStreetCategories__c fixmystCat1 = new FixMyStreetCategories__c(
			service_code__c = 'RC17',
            Name = 'Fly Tipping',
            InternalQueue__c = 'Internal Street Scene Waste Queue',
            Send_to_Confirm__c = false
            );
		insert fixmystCat1;
        
        FixMyStreetCategories__c fixmystCat2 = new FixMyStreetCategories__c(
			service_code__c = 'RC18',
            Name = 'Graffiti',
            InternalQueue__c = 'Unknown Queue',
            Send_to_Confirm__c = false
            );
		insert fixmystCat2;
        
      Object res1  =  FixMyStreetCreateCase.GetFixMyStreetExtends(fixmystCat1.Id);
        
       FixMyStreetCreateCase.ConfirmLogEntry('Test'); 
     
     
FixMyStreetToConfirm__c fixmyConfirmObj = new   FixMyStreetToConfirm__c(
	FixMyStreetCategories__c = fixmystCat1.Id,
    SecondField__c = 'extends_rc17_type_of_rubbish__c'
);                      
		insert fixmyConfirmObj;
FixMyStreetToConfirm__c fixmyConfirmObj1 = new   FixMyStreetToConfirm__c(
	FixMyStreetCategories__c = fixmystCat2.Id,
    SecondField__c = 'Extends_RC18_Graffiti_Type__c'
);                      
		insert fixmyConfirmObj1;
        
        
     // create a fixmystreet
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
            extends_rc17_type_of_rubbish__c = 'Type of Rubbish',
            requested_datetime__c = DateTime.now()
        );
		insert fixmyObj;
        
        FixMyStreetCreateCase.NewCaseFromFixMyStreetId(fixmyObj.Id,true);
        FixMyStreetCreateCase.NewCaseFromFixMyStreetId(fixmyObj.Id,false);


      // create a fixmystreet

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
        
        FixMyStreetCreateCase.NewCaseFromFixMyStreetId(fixmyObj.Id,false);
        FixMyStreetCreateCase.NewCaseFromFixMyStreetId(fixmyObj.Id,true);

     // create a fixmystreet
        FixMyStreet__c fixmyObj2 = new FixMyStreet__c(
          Service_Area__c = fixmystCat2.Id,
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
            extends_rc18_graffiti_type__c = 'Other',
            requested_datetime__c = DateTime.now()
        );
		insert fixmyObj2;
        
        FixMyStreetCreateCase.NewCaseFromFixMyStreetId(fixmyObj2.Id,false);
        FixMyStreetCreateCase.NewCaseFromFixMyStreetId(fixmyObj2.Id,true);
        
        
        
        List<FixMyStreetCreateCase.FMSRequests> requests = new List<FixMyStreetCreateCase.FMSRequests> ();
        FixMyStreetCreateCase.FMSRequests newreq = new FixMyStreetCreateCase.FMSRequests();
        newreq.fixmystreetId = fixmyObj.Id;
        requests.add(newreq);
        
        FixMyStreetCreateCase.doCreationCase(requests);
        
    }
}