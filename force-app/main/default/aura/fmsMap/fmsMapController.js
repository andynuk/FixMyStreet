({
	jsLoaded: function(component) {
  		var mapDiv = component.find('mapid').getElement();
        //var mymap = L.map(mapDiv).setView([52.66667, -0.73333], 13);
  		var mymap = L.map(mapDiv, {zoomControl: true,zoom:1,zoomAnimation:false,fadeAnimation:true,markerZoomAnimation:true}).setView([52.66667, -0.73333], 13);
        component.set("v.map", mymap);

        
        L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiYW5keW51ayIsImEiOiJjamJiOTE0cGgxNjVkMzBwc3hqbzc1eXd4In0.1u1WjA3E0-ZFSqPJY7b6hQ', {
            attribution: 'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
            maxZoom: 18,
            id: 'mapbox.streets',
            accessToken: 'pk.eyJ1IjoiYW5keW51ayIsImEiOiJjamJiOTE0cGgxNjVkMzBwc3hqbzc1eXd4In0.1u1WjA3E0-ZFSqPJY7b6hQ'
        }).addTo(mymap);
        
        
        var markers = L.layerGroup().addTo(mymap);       
        component.set("v.markers", markers);

    },
    
    handleUpdateFilter : function(component, event, helper) {
        console.log("Arrived at Map view");
        var eventfixmystreets = event.getParam("fixmystreets");
        component.set("v.fms",eventfixmystreets);
        helper.addMarkers(component);
     },
       
    
    
    handleSelectedSObject: function(component, event, helper) {
	    console.log("handleSelectedSObject");
        
        var id = event.getParam("recordId");
        console.log(id);
        helper.loadResults(component,id);
	    console.log("end handleSelectedSObject");
     },
    
   
})