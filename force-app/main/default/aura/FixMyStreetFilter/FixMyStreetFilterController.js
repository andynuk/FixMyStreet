({
    doInit: function(component, event, helper) {
        console.log('FixMyStreetSelector - doInit');
 	  	helper.loadcategoryClasses(component);    
 	  	helper.loadstatusClasses(component);    
        console.log('FixMyStreetSelector - return - doInit');
	},
    	
    changeHandler : function(component, event, helper) {
        console.log("Event:  changeHandler");
       var status = component.get("v.selectedFilterStatusValue");
       var category = component.get("v.selectedFilterCategoryValue");
       console.log("status :");
       console.log(status);
       console.log("category :");
       console.log(category);
       
       
       	 helper.loadFilteredResults(component,status, category);
      
     
       

     
     //   var changeEvent = $A.get("e.c:ValueChange");
     //     changeEvent.setParams({
     //       "value": id,
     //        "status": status
     //   });
     //   changeEvent.fire();
    }
})