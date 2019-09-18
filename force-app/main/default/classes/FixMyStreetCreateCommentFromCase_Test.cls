@isTest
public class FixMyStreetCreateCommentFromCase_Test {
 

    
    @isTest
    static void tests() {
        
             // create a case
        FixMyStreetCategories__c fixmystCat = new FixMyStreetCategories__c(
			service_code__c = 'RC01'
            );
		insert fixmystCat;


     // create a fms and then case
        Case newCase = new Case(
            Status = 'Investigating',
            Subject  = 'Test Case'
        );
        insert newCase;


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
            Case__c = newCase.Id
        );
		insert fixmyObj;


      //FixMyStreetCommentsStatusChange.addCommentsFromCase(newCase.Id);
 
      List<FixMyStreetCreateCommentFromCase.FMSRequests> requests = new List<FixMyStreetCreateCommentFromCase.FMSRequests>();

      FixMyStreetCreateCommentFromCase.FMSRequests request = new FixMyStreetCreateCommentFromCase.FMSRequests();
      request.caseId = newCase.Id;

      requests.add(request);

      FixMyStreetCreateCommentFromCase.doComment(requests);

        newCase.Status = 'Passed to contractor';
        upsert newCase;
      FixMyStreetCreateCommentFromCase.doComment(requests);

        newCase.Status = 'Closed';
        newCase.FixMyStreet_Public_Comment__c = 'public comment';
        upsert newCase;
      FixMyStreetCreateCommentFromCase.doComment(requests);


    }
}