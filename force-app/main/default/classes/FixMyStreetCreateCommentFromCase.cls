global with sharing class FixMyStreetCreateCommentFromCase {

	@InvocableMethod(label='FixMyStreet Create Comment from Case' description='Used to create a comment from the case FMS comments')
    public static void doComment(List<FMSRequests> requests) {

        
        if (requests == null)
       {
           system.debug('No id sent to doCreationConfirmRecord');
           return;
       }

        FMSRequests firstRequest = requests[0];
        
       Id CaseId = firstRequest.caseId;
        CreateComment(caseId);
    }

    
    global  class FMSRequests {

        @InvocableVariable
       global Id caseId;
    }

    public static void CreateComment(Id caseId) {

    // get case comment
    Case caseComment = [SELECT FixMyStreet_Public_Comment__c FROM Case where Id =: caseId LIMIT 1];

    // get the FixMyStreet info
    FixMyStreet__c fms = [SELECT Id,New_update_Comments__c,Name, Status__c from FixMyStreet__c WHERE Case__c=: caseId LIMIT 1];

    if (fms!=null)
    {   
        fms.New_update_Comments__c = caseComment.FixMyStreet_Public_Comment__c;
        fms.Status__c = 'Closed';
        fms.Update_FixMyStreet__c = true;
       upsert fms;
       // no remove comment on case
       caseComment.FixMyStreet_Public_Comment__c = '';
       upsert caseComment;
    }

    }
}