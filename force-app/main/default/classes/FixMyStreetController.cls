global with sharing class FixMyStreetController {
    
    public class PagedResult {
        
        @AuraEnabled
        public Integer pageSize { get;set; }
        
        @AuraEnabled
        public Integer page { get;set; }
        
        @AuraEnabled
        public Integer total { get;set; }
        
        @AuraEnabled
        public List<FixMyStreet__c> fixmystreets { get;set; }
        
    }


      @AuraEnabled
    public static PagedResult getResults(string status) {
        
    // each service category can use additonal fields to extend information
    // example  cateogy name abandoned Vehicles which is Service Code RC11 has fields in the main
    // Extends_RC11_xxxxx 
        
    Map<String, Schema.SObjectField> fieldsResult = Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap();
   //get object fields
    List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap().keySet());
    String fields = String.join(fieldList,','); 
        
 
        

        Integer pSize = 0;
        PagedResult r =  new PagedResult();
        r.pageSize = pSize;
        r.page = 1;
        
        string soql = 'SELECT ' + fields + ',Service_Area__r.Name,Service_Area__r.Service_Code__c FROM FixMyStreet__c';
        if (status != 'All')
        	{
             soql = soql + ' where Status__c = : status';
        	}
        system.debug('####' + soql);
        system.debug('####' + status);
        r.fixmystreets = database.query(soql);
        
        return r;
    }

    @AuraEnabled
    public static PagedResult getFilteredResults(string status, string category) {
 
    // each service category can use additonal fields to extend information
    // example  cateogy name abandoned Vehicles which is Service Code RC11 has fields in the main
    // Extends_RC11_xxxxx 
        
    Map<String, Schema.SObjectField> fieldsResult = Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap();
   //get object fields
    List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap().keySet());
    String fields = String.join(fieldList,','); 
        
        system.debug('#### status: ' + status);
        system.debug('#### category: ' + category);
       


        String strCategory;
        if (category == 'All')
        {
        	strCategory = 'All';
        }
        else
        {
        	strCategory = Id.valueOf(category);
        }
        
        system.debug('####' + strCategory);
        system.debug('####' + status);        
        
        Integer pSize = 0;
        PagedResult r =  new PagedResult();
        r.pageSize = pSize;
        r.page = 1;
    //    string soql = 'SELECT ' + fields + ',Service_Area__r.Name,Service_Area__r.Service_Code__c FROM FixMyStreet__c where Service_Area__c = :filter and Status__c = : status';
        string soql = 'SELECT ' + fields + ',Case__r.Status, Case__r.CaseNumber, Service_Area__r.Name,Service_Area__r.Service_Code__c FROM FixMyStreet__c';

        // ignoring status looking for open cases
        status = 'New';
        if (category != 'All')
        {
            soql = soql +  ' where Service_Area__c = :strCategory AND Case__r.Status=: status'; 
        } 
        else
        {
            soql = soql +  ' where Case__r.Status= :status'; 
        } 
            

            soql = soql +  ' ORDER BY CreatedDate DESC'; 
        
        
/*        if (status =='All')
        {
        	if (category != 'All')
        	{
         	soql = soql +  ' where Service_Area__c = :strCategory'; 
        	}        	
        }
        else
        {
        	if (category != 'All')
        	{
         	soql = soql +  ' where Service_Area__c = :strCategory and Status__c = : status'; 
        	}        	
        	else
        	{
         	soql = soql +  ' where Status__c = : status'; 
        	}        	
        }*/
        
        system.debug('####' + soql);

       
        
        r.fixmystreets = database.query(soql);
        
        return r;
    }    

    @AuraEnabled
    public static FixMyStreetCategories__c[] getCategories() {
        return [SELECT Id, Name FROM FixMyStreetCategories__c ORDER BY Name];
    }
    
    @AuraEnabled
    public static List<String> getStatus() {
 
        list<String> MyList = new list<String> ();
 
		Schema.DescribeFieldResult fieldResult = FixMyStreet__c.Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
   		{
            MyList.add(f.getLabel());
  		 }   
        
       
        return MyList;
    }
    
}