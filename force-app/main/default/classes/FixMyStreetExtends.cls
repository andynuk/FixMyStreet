@RestResource(urlMapping='/FixMyStreetInfo/*')
global with sharing class FixMyStreetExtends {

public class Parent {
    public String title;
    public Child[] fieldInformation = new Child[] {};
	}

public class Child {
    public String name;
    public String label;
    public String fieldType;
    public String length;
    public String[] optionsList = new String[] {};
	}

public class Parent1 {
    public String title;
    public Child1[] CategoryInformation = new Child1[] {};
	}

public class Child1 {
    public string serviceid;
    public String name;
    public String name_code;
	}
    
    @HttpGet
    global static void getFixMyStreet() {
        RestRequest request = RestContext.request;
        
        RestRequest req = RestContext.request;
        String p_extend_id = req.params.get('id');
        String p_extend_name_code = req.params.get('name_code');
        String p_summary = req.params.get('summary');

       	String result = ''; 
        
        if (p_summary != null){
 	        Parent1 p = new Parent1();
        	p.title = 'Summary Categories';
 
            List<FixMyStreetCategories__c> categoryList =  database.query('SELECT Name,Service_Code__c FROM FixMyStreetCategories__c where Live__C=true');
            for (FixMyStreetCategories__c category: categoryList) {
	            Child1 c = new Child1();
    	        c.name = category.Name;
        	    c.name_code = category.Service_Code__c;
                c.serviceid = category.id;
            	p.CategoryInformation.add(c);
            }
            
            result = JSON.serializePretty(p);     
        }
            
        
		if (p_extend_id != null || p_extend_name_code != null) {
            string servicecategory;
            if (p_extend_name_code!=null)
            {
                servicecategory = p_extend_name_code;
            }
            else
            {
                // need to look up friendly description of code from id
                FixMyStreetCategories__c res_category =  database.query('SELECT service_code__c FROM FixMyStreetCategories__c where Live__C=true and Id=:p_extend_id');
				servicecategory = res_category.service_code__c;
            }
	        Parent p = new Parent();
             Map<String, Schema.SObjectField> fieldsResult = Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap();
            //get object fields
            List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get('FixMyStreet__c').getDescribe().fields.getMap().keySet());
            String fields = String.join(fieldList,',');       
            p.title = servicecategory;
            
            for (String fieldName: fieldsResult.keySet()) {
               if (fieldName.startsWithIgnoreCase('Extends_'+servicecategory))
                {
                 Child c = new Child();
        		 c.name = fieldname;
        		 c.label = fieldsResult.get(fieldname).getDescribe().getLabel();
                 Schema.DisplayType fielddataType = fieldsResult.get(fieldname).getDescribe().getType();
                    if (fielddataType == Schema.DisplayType.String) {
				   	 	c.fieldType = 'text';
                        Integer length = fieldsResult.get(fieldname).getDescribe().getLength();
                        c.length = String.valueOf(length);
                    } else if (fielddataType == Schema.DisplayType.TextArea) {
				   	 	c.fieldType = 'text';
                        Integer length = fieldsResult.get(fieldname).getDescribe().getLength();
                        c.length = String.valueOf(length);
                    } else if (fielddataType == Schema.DisplayType.Picklist) {
				   	 	c.fieldType = 'options';
                        List<Schema.PicklistEntry>Picks =fieldsResult.get(fieldname).getDescribe().getpicklistValues();
                        for (Schema.PicklistEntry pick: Picks) {
                        c.optionsList.add(pick.getValue());
                        }
                    } 
        		 p.fieldInformation.add(c);
                }    
    		}
       // always add in additional information
       //Child cAddInfo = new Child();
       //cAddInfo.name = 'extends_additional_information__c';
       //cAddInfo.label = 'Additional Information';
       //cAddInfo.fieldType = 'text';
       //cAddInfo.length = '1000';
       //p.fieldInformation.add(cAddInfo);
       result = JSON.serializePretty(p);     
       // end of p_extend as id
       }
        

	RestContext.response.addHeader('Content-Type', 'application/json;charset=UTF-8');
	RestContext.response.responseBody = Blob.valueOf(result);
   }


}