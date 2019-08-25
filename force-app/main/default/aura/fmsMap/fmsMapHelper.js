({
    addMarkers: function(component) {
        console.log("starting add markers");
        var map = component.get('v.map');
        var markers = component.get('v.markers');
        var fms = component.get('v.fms');
        
        // clear any existing items on markers layer
        markers.clearLayers();
  
     
 		// add points to marker layer                    
        for (var i=0;  i<fms.length; i++){
            var title = fms[i].Name + ": " + fms[i].title__c;
            if (fms[i].lat__c != null && fms[i].long__c !=null){
 		    window.L.marker([fms[i].lat__c , fms[i].long__c]).addTo(markers).bindPopup(title);
 		    console.log(fms[i].lat__c , fms[i].long__c,title);
        	}
        }
        
        
    }
})