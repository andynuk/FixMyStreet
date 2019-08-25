({
   jsLoaded: function(component, event, helper) {
       
  		var mapDiv = component.find('mapid').getElement();
  		var mymap = L.map(mapDiv, {zoomControl: true,zoom:1,zoomAnimation:false,fadeAnimation:true,markerZoomAnimation:true}).setView([52.635985, -0.627849], 12);
        component.set("v.map", mymap);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
            maxZoom: 18,
            id: 'openstreetmap'
        }).addTo(mymap);
 
       
        
       
       

  function onMapClick(e) {
	    var marker = component.get("v.marker");
    	console.log(marker);
	    if (marker != null)
    		{
       		mymap.removeLayer(marker);
        	}
		marker = L.marker(e.latlng).addTo(mymap);
        component.set("v.marker",marker);
		marker.bindPopup("<h1>Location of Problem.  Please click 'next' to collect details.</h1>").openPopup();
      component.set("v.Lat", e.latlng.lat);
      component.set("v.Long", e.latlng.lng);
      component.set("v.disableNext", "false");
  		}
       
       
      // only allow onclick to map if not a highways issue
      // highways issues need the sitecode
	  mymap.on('click', onMapClick);
//      if (component.get("v.ServiceArea")!='Highways')
//      {
//	  mymap.on('click', onMapClick);
//      }
  },
    
 
   doInit: function(component,event,helper) {
       
    }, 
    
    
    
    handleClick : function(component,event,helper) {
      var navigate = component.get('v.navigateFlow')
      navigate('NEXT');       
    }, 
    
    handlePreviousClick : function(component,event,helper) {
      var navigate = component.get('v.navigateFlow')
      navigate('BACK');       
    },     
    
   handleLookupEvent: function(component, event, helper) {

        console.log('handleLookupEvent');
        console.log(component.get("v.StreetId"));
        
        var action = component.get("c.getStreetInfo");
        action.setParams({ "StreetId" : component.get("v.StreetId") })
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var ret = a.getReturnValue();
  
            var mymap = component.get("v.map");
            mymap.setView(new L.LatLng(ret.Lat__c, ret.Long__c), 16);
    		var marker = component.get("v.marker");
    		console.log(marker);
      
            if (marker == null)
                {
                marker = L.marker([ret.Lat__c, ret.Long__c]).addTo(mymap);
                component.set("v.marker",marker);
                marker.bindPopup("<h1>Location of Problem.  Please click 'next' to collect details.</h1>").openPopup();
                }
               else
               {
                mymap.removeLayer(marker);
                marker = L.marker([ret.Lat__c, ret.Long__c]).addTo(mymap);
                component.set("v.marker",marker);
                marker.bindPopup("<h1>Location of Problem.  Please click 'next' to collect details.</h1>").openPopup();
               }
           
            
            component.set("v.Lat", ret.Lat__c);
            component.set("v.Long", ret.Long__c);            
            component.set("v.SiteCode", ret.site_code__c);
            component.set("v.disableNext", "false");
            });
        console.log('Queuing the action');
        $A.enqueueAction(action);
   },
 
    
})