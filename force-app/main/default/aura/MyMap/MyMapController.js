({
   jsLoaded: function(component, event, helper) {
       
       console.log("Starting jsLoaded");
 
           console.log("setup map");
  		var mapDiv = component.find('mapid').getElement();
  		var mymap = L.map(mapDiv, {zoomControl: true,zoom:1,zoomAnimation:false,fadeAnimation:true,markerZoomAnimation:true}).setView([52.66667, -0.73333], 11);
        component.set("v.map", mymap);

        
        console.log("set main tile Layer");
        L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiYW5keW51ayIsImEiOiJjamJiOTE0cGgxNjVkMzBwc3hqbzc1eXd4In0.1u1WjA3E0-ZFSqPJY7b6hQ', {
            attribution: 'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
            maxZoom: 18,
            id: 'mapbox.streets',
            accessToken: 'pk.eyJ1IjoiYW5keW51ayIsImEiOiJjamJiOTE0cGgxNjVkMzBwc3hqbzc1eXd4In0.1u1WjA3E0-ZFSqPJY7b6hQ'
        }).addTo(mymap);
        
        

        console.log("set marker Layer");
        var markers = L.layerGroup().addTo(mymap);       
        component.set("v.markers", markers);       

       var fixMyStreet = component.get('v.simpleRecord');
		//console.log(fixMyStreet);
       if (fixMyStreet == null)
       {
       	console.log("no fms record ready");
       }
       else
       {
       	console.log("jsload - add marker");
		helper.addMarkers(component);
        console.log("jsload - end add marker");  
        }           
      console.log("end of jsload");
  },
    
    recordUpdated: function(component, event, helper) {
    console.log("start recordUpdated");

    var changeType = event.getParams().changeType;

    if (changeType === "ERROR") { /* handle error; do this first! */ }
    else if (changeType === "LOADED") {
        var map = component.get('v.map');
        var markers = component.get('v.markers');
        var fixMyStreet = component.get('v.simpleRecord');
		//console.log(fixMyStreet);
       if (fixMyStreet==null || markers==null || markers==null)
       {
       	console.log("recordUpdated - no fms record ready");
       }
       else
       {
       	console.log("recordUpdated - add marker");
		helper.addMarkers(component);
        console.log("recordUpdated - end add marker");  
        } 
  	}
    else if (changeType === "REMOVED") { /* handle record removal */ }
    else if (changeType === "CHANGED") { /* handle record change */ }
    console.log("end recordUpdated");
    },
 
   doInit: function(component,event,helper) {
       
       console.log("doInit");
       var fixMyStreet = component.get('v.simpleRecord');
	//console.log(fixMyStreet);
       if (fixMyStreet == null)
       {
       	console.log("no fms record ready");
       }
       else
       {
       	console.log("oninit - add marker");
		helper.addMarkers(component);
        console.log("oninit - end add marker");
        }
    }    
})