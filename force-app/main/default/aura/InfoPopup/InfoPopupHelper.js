({
	helperMethod : function() {
		
	},
    
    getExtend: function(component) {
 
        console.log('### getExtend ###');
        
        var fixmystreet = component.get("v.fixmystreet");
        console.log(fixmystreet);
        
        var service = fixmystreet.Service_Area__r;
        var category = 'Extends_' + service.Service_Code__c;
        console.log(category);

        var extendItems = [];
        var prop;
        for(prop in fixmystreet)
        {
            if(prop.indexOf(category)==0)
            {
            var ob = [prop, fixmystreet[prop]];
            console.log(ob);
            extendItems.push(ob);
            //extendItems.push(prop,fixmystreet[prop]);
            //extendItems.push(fixmystreet[prop]);    
            }
        }
        
      
        component.set("v.extend", extendItems);
    }
})