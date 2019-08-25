public class StreetLLPGController {

    @AuraEnabled
    public static List<FixMyStreet__c> GetStreetSceneHistory (Id ServiceArea) {
        List<FixMyStreet__c> streetsceneHistory;
        //streetsceneHistory = [SELECT id, Name, requested_datetime__c,Location__c,Status__c,Service_Area__c, Case__r.CreatedDate FROM FixMyStreet__c WHERE Service_Area__c =: ServiceArea order by Case__r.CreatedDate DESC LIMIT 5];
        //streetsceneHistory = [SELECT id, Name,Location__c,Status__c,Service_Area__c, Case__r.CreatedDate FROM FixMyStreet__c WHERE Service_Area__c =: ServiceArea ORDER BY Case__r.CreatedDate DESC LIMIT 10];
        streetsceneHistory = [SELECT id, Name, lat__c, long__c, requested_datetime__c,Location__c,Status__c,Service_Area__c,Service_Area__r.Name, Case__r.CreatedDate FROM FixMyStreet__c where Service_area__c =: ServiceArea AND requested_datetime__c!=null order by requested_datetime__c DESC LIMIT 5];
        return streetsceneHistory;
    }
    
    
@AuraEnabled
public static Street_LLPG__c getStreetInfo(Id StreetId) {
    List<Street_LLPG__c> result = [SELECT id, site_code__c,Xstart__c,Ystart__c  FROM Street_LLPG__c WHERE Id = : StreetId];
    System.debug(result);
    


        string X =   String.valueOf(result[0].Xstart__c);
        string Y =   String.valueOf(result[0].Ystart__c);
    
     //   string lat =   String.valueOf(fixmystreet.lat__c);
     //   string lng =   String.valueOf(fixmystreet.long__c);
        
        string url = 'https://www.bgs.ac.uk/data/webservices/CoordConvert_LL_BNG.cfc?method=BNGToLatLng&easting='+X+'&northing='+Y;
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Length','0');

         
        

    if(!Test.isRunningTest()) {
        // under  Test we cannot make web service call outs
        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }        
    }
    else
            {
                res.setHeader('Content-Type', 'application/json');
                res.setBody('{"DEGMINSECLNG":{"DEGREES":-1,"SECONDS":24,"MINUTES":32},"EASTING":451030.444044407,"LONGITUDE":-1.54,"ERROR":false,"DEGMINSECLAT":{"DEGREES":-5,"SECONDS":0,"MINUTES":33},"NORTHING":-6141064.83570885,"LATITUDE":-5.55} ');
                res.setStatusCode(200);
            } 
        
        
        System.debug(res.getBody());

        Map<String, Object> m = (Map<String, object>) JSON.deserializeUntyped(res.getBody());
        System.debug('------');
        System.debug(m);
        System.debug('------');
        System.debug(m.keySet());
        System.debug(m.get('LATITUDE'));
        System.debug(m.get('LONGITUDE'));
        
        // when the record is returned a unique payment reference is created
        Double Lat = Double.valueOf(m.get('LATITUDE'));
        Double Lng = Double.valueOf(m.get('LONGITUDE'));
        
        System.debug(Lat);
        System.debug(Lng);
        
        result[0].Lat__c =  Lat;
    	result[0].Long__c =  Lng;
         upsert result;                               
    
    
    return result[0];
}
        
}