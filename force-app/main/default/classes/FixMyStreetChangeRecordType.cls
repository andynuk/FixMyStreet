global with sharing class FixMyStreetChangeRecordType {

    
	@InvocableMethod
    public static void fixMyStreetChangeRecordType(List<fixMyStreetChangeRecordTypeRequests> requests) {

        
        if (requests == null)
       {
           system.debug('No id sent to fixMyStreetChangeRecordType');
           return;
       }

        fixMyStreetChangeRecordTypeRequests firstRequest = requests[0];
        
       Id fixmystreetId = firstRequest.fixmystreetId;

        // look up Service_Code of record

        FixMyStreet__c fms = [SELECT Service_Area__r.Service_Code__c, RecordTypeId FROM FixMyStreet__c WHERE Id=:fixmystreetId LIMIT 1];
        string rec = fms.Service_Area__r.Service_Code__c;

        Schema.RecordTypeInfo recordInfo = Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().getRecordTypeInfosByName().get(rec);

        if (recordInfo != null)
            {

            Id newRecordTypeId = Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().getRecordTypeInfosByName().get(rec).getRecordTypeId();

            if (newRecordTypeId != null)
                {
                fms.RecordTypeId = newRecordTypeId; 
                upsert fms;
                }
            }
    }

    
    global  class fixMyStreetChangeRecordTypeRequests {
        @InvocableVariable
        global Id fixmystreetId;
    }

}
