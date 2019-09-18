@IsTest
public class StreetLLPGController_Test {

      static testMethod void  testStreetLLPGController(){
   
         
   Test.startTest();
   

      // create a case
        FixMyStreetCategories__c fixmystCat = new FixMyStreetCategories__c(
			service_code__c = 'RC01',
            Live__C = true
            );
		insert fixmystCat;

        RCCInternalReportSSDetailCtl.GetFixMyStreetExtends(fixmystCat.Id);

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

    StreetLLPGController.GetStreetSceneHistory(fixmystCat.Id);

   Street_LLPG__c  testStreet = new Street_LLPG__c(
       site_code__c = 'code',
       Xstart__c = 0,
       Ystart__c = 0
   );
    upsert testStreet;

    StreetLLPGController.getStreetInfo(testStreet.Id);

      Test.stopTest();
   }
}