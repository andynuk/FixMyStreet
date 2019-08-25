({
   jsLoaded: function(component, event, helper) {
       
  		var mapDiv = component.find('mapid').getElement();
  		var mymap = L.map(mapDiv, {zoomControl: true,zoom:1,zoomAnimation:false,fadeAnimation:true,markerZoomAnimation:true}).setView([52.635985, -0.627849], 11);
        component.set("v.map", mymap);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
            maxZoom: 18,
            id: 'openstreetmap'
        }).addTo(mymap);
 
       
        // map now all set up go and collect old calls
        console.log("Internal Street Scene History being called");
        console.log("--------------");
        console.log(component.get("v.ServiceArea"));
        var action = component.get("c.GetStreetSceneHistory");
        action.setParams({ "ServiceArea" : component.get("v.ServiceArea") })
        
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var retDates = a.getReturnValue();
            console.log(" Returned history :",retDates);
            retDates.forEach(function(entry) {
                console.log(entry);
                if (entry.lat__c!=null && entry.long__c!=null)
                {
                var marker = L.marker([entry.lat__c,entry.long__c]).addTo(mymap);
                var popupSt = "";
                if (entry.Service_Area__r) {
                    popupSt = "<b>"+entry.Service_Area__r.Name+"</b><br/>";
                }
                popupSt = popupSt + "<b>"+entry.Name+"</b><br/><br/>"
                if (entry.Location__c) {
                    popupSt = popupSt + "Location :  "+entry.Location__c+"<br/>";
                }
                if (entry.Status__c) {
                    popupSt = popupSt + "Status :  "+entry.Status__c+"<br/>";
                }
                if (entry.Update_Comments__c) {
                    popupSt = popupSt + "Comments :  "+entry.Update_Comments__c+"<br/>";
                }
                 
                if (entry.requested_datetime__c ) {
                    // example 2018-10-31T12:58:00.000Z
                    //console.log(entry.requested_datetime__c);
                    //console.log(entry.requested_datetime__c.substring(0,4));
                    //console.log(entry.requested_datetime__c.substring(5,7));
                    //console.log(entry.requested_datetime__c.substring(8,10));
                    var mydate = new Date(entry.requested_datetime__c.substring(0,4), entry.requested_datetime__c.substring(5,7)-1, entry.requested_datetime__c.substring(8,10)); 
                    console.log(mydate.toDateString());
                    popupSt = popupSt + "Date :  "+mydate.toDateString()+"<br/>";
                }
                marker.bindPopup(popupSt).openPopup();
                }
            });
            //component.set("v.streetsceneHistory",retDates);
        });
       console.log('Queuing the action');
       $A.enqueueAction(action);
       
       
       

  },
   	
})