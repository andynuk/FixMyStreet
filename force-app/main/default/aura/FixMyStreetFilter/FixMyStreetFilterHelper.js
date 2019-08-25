({
	helperMethod : function() {
		
	},
	loadcategoryClasses : function(component) {
        console.log("FixMyStreet Selector : Helper : loadcategoryClasses : Start");
       var action = component.get("c.getCategories");
    	action.setCallback(this, function(response) {
            var categoryClasses = response.getReturnValue();
            //categoryClasses.unshift("");
            //window.DataCache.setData("categoryClasses", categoryClasses);
            component.set("v.categoryClasses", categoryClasses);
            //console.log("category classes retrieved from server");
    	});
    	$A.enqueueAction(action);
        //console.log("FixMyStreet Selector : Helper : loadcategoryClasses : End");
	},
	loadstatusClasses : function(component) {
        console.log("FixMyStreet Selector : Helper : loadstatusClasses : Start");
       var action = component.get("c.getStatus");
    	action.setCallback(this, function(response) {
            var statusClasses = response.getReturnValue();
            //console.log(statusClasses);
            //categoryClasses.unshift("");
            //window.DataCache.setData("categoryClasses", categoryClasses);
            component.set("v.statusClasses", statusClasses);
            console.log("satus classes retrieved from server");
    	});
    	$A.enqueueAction(action);
        //console.log("FixMyStreet Selector : Helper : loadstatusClasses : End");
	},

	loadFilteredResults : function(component, status, category) {
        var action = component.get("c.getFilteredResults");
        action.setStorable();
		action.setParams({
            "status": status,
      		"category": category
     	});
    	action.setCallback(this, function(response) {
            console.log('# getFixMyStreet callback %f', (performance.now() - startTime));
			var result = response.getReturnValue();
            component.set("v.fixmystreets", result.fixmystreets);
            //component.set("v.page", result.page);
            //component.set("v.total", result.total);
            console.log(result.fixmystreets);
            var changeEvent = $A.get("e.c:FixMyStreetFilterListChange");
            changeEvent.setParams({
            	"fixmystreets": result.fixmystreets,
            	});
            changeEvent.fire();
            console.log('# end of filter results call');
          	});
        var startTime = performance.now();
    	$A.enqueueAction(action);
	},    

})