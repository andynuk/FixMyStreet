({
    doInit: function(component, event, helper) {
      //helper.loadResults(component,'All'); 
    },
    
    
    handleUpdateFilter : function(component, event, helper) {
        console.log("Arrived at List view");
        var eventfixmystreets = event.getParam("fixmystreets");
        component.set("v.fixmystreets",eventfixmystreets);
     },
    
    
	onMouseMove: function(component, event, helper) {
        if (event.target === event.currentTarget) return;
        var el = event.target;
        while (el && (!el.dataset || !el.dataset.id)) {
            el = el.parentElement;
        }
        if (el) {
			var fixmystreets = component.get("v.fixmystreets");
            //component.find("popup").showPopup(fixmystreets[el.dataset.id], event.clientX + 20, el.offsetTop - 46);
        }
    },

    onMouseLeave: function(component, event, helper) {
        if (event.target === component.find("list").getElement()) {
	        //component.find("popup").hidePopup();    
        }
    }

})