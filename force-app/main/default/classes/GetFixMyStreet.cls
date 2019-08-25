public with sharing class GetFixMyStreet {

@AuraEnabled
public static List<FixMyStreet__c> getFixMyStreet(Id recordId) {
    List<FixMyStreet__c> result = [SELECT id, name, lat__c,long__c,title__c, Description__c,requested_datetime__c, Contact_Email__c,Contact_Name__c,Contact_Phone__c,requestor_name__c, Service_Area__c, Service_Area__r.Service_Code__c,status__c,Update_Comments__c, Detail__c,Extends_Additional_Information__c  FROM FixMyStreet__c WHERE Id = : recordId];
    System.debug(result);
    return result;
}
    
@AuraEnabled
public static List<FixMyStreet__c> getAllFixMyStreet() {
    List<FixMyStreet__c> result =  [SELECT id, name, lat__c,long__c,title__c, Description__c,requested_datetime__c, Contact_Email__c,Contact_Name__c,Contact_Phone__c,requestor_name__c, Service_Area__c, Service_Area__r.Service_Code__c, status__c,Update_Comments__c, Detail__c, Extends_Additional_Information__c FROM FixMyStreet__c];
    System.debug('######');
    System.debug(result[0]);
    System.debug('######');
    return result;}
    
}