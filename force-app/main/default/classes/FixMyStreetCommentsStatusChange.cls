global with sharing class FixMyStreetCommentsStatusChange {


	@InvocableMethod(label='FixMyStreet Comments from Case' description='Used to add updates when the case status changes')
    public static void doCommentsFromCase(List<FMSRequests> requests) {

        
        if (requests == null)
       {
           system.debug('No id sent to doCommentsFromCase');
           return;
       }

        FMSRequests firstRequest = requests[0];
        
       Id caseId = firstRequest.caseId;
       system.debug('Add comments for  '+ caseId);
        addCommentsFromCase(caseId);
    }

    
    global  class FMSRequests {
        @InvocableVariable
        global Id caseId;
    }

    public static void addCommentsFromCase(Id caseId) {


    // get case status
    Case caseDetails = [SELECT Status FROM Case where Id =: caseId LIMIT 1];


    // get the FixMyStreet info
    List<FixMyStreet__c> fms = [SELECT Id,New_update_Comments__c,Name, Status__c from FixMyStreet__c WHERE Case__c=: caseId LIMIT 1];

    // search for say 'Case - Investigating'
    string findCaseStatus = 'Case - '+caseDetails.Status;

    List<FixMyStreet_Updates__mdt> fms_Status_Description = [SELECT MasterLabel, Update_Text__c, FMS_Status__c  FROM FixMyStreet_Updates__mdt WHERE MasterLabel = :findCaseStatus LIMIT 1];

    
    if (fms_Status_Description.size() != 0  && fms.size() != 0)
        {
        string newComments = fms_Status_Description[0].Update_Text__c;
        system.debug(newComments);

        FixMyStreet__c fmsUpdate = fms[0];
        fmsUpdate.Update_FixMyStreet__c = true;

        fmsUpdate.New_update_Comments__c = newComments;
        if (fms_Status_Description[0].FMS_Status__c != null)
            {
            fmsUpdate.Status__c = fms_Status_Description[0].FMS_Status__c;
            }
        upsert fmsUpdate;
        }

    }
}