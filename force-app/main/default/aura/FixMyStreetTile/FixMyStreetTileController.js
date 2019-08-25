({
	fixMyStreetSelected : function(component, event, helper) {
	
		
        var fixmystreet = component.get("v.fixmystreet");
        /* this code fires off the selected event
		var selectSObjectEvent = $A.get("e.ltng:selectSObject");
         selectSObjectEvent.setParams(
            {
                "recordId": fixmystreet.Id
            });
        selectSObjectEvent.fire();
        */
        
        
     /* This code opens detail page   */
        var navEvt = $A.get("e.force:navigateToSObject");
    	navEvt.setParams({
      	"recordId": fixmystreet.Id,
      	"slideDevName": "detail"
    	});
    	navEvt.fire();
      
	},
    	fixMyStreetCaseSelected : function(component, event, helper) {
        var fixmystreet = component.get("v.fixmystreet");
     /* This code opens detail page   */
        var navEvt = $A.get("e.force:navigateToSObject");
    	navEvt.setParams({
      	"recordId": fixmystreet.Case__c,
      	"slideDevName": "detail"
    	});
    	navEvt.fire();
      
	}
    
})