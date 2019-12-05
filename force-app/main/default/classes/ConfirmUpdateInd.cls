global class ConfirmUpdateInd Implements Schedulable {

    
    public Interface IScheduleDispatched
    {
        void execute(SchedulableContext sc);
    }
    
    global void execute(SchedulableContext sc)
    {
		ConfirmUpdatesInd();
	}
	
   // @future (callout=true)
    public static void ConfirmLogEntry(string log) {
        // send the result to the log object
        FixMyStreet_Log__c logEntry = new FixMyStreet_Log__c();
        logEntry.Log__c = log;
        insert logEntry;
    }
	
    
    @future (callout=true)
    public static void ConfirmUpdatesInd() {

        string enquiryRef = '11002134';

        system.debug('Collecting update from Confirm');
		
        Boolean logError = false;
        string logEntry = 'Collecting specific update from Confirm\r\n';
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        string orgId = UserInfo.getOrganizationId();
        system.debug('OrgId: '+orgId);
        boolean production = false;
        if (orgId == '00D0Y000002EzYY')
        {
            production = true;
        }
        string ConfirmUrl;
        string ConfirmPassword;
        string ConfirmDatabaseId;
        
         if (production)
        {
            //ConfirmUrl = 'https://connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx';
            ConfirmUrl = 'https://production-awswebservices.ondemand.confirm.co.uk/confirm/connector/confirmconnector.asmx';
            ConfirmPassword = 'Enquiri3s';
            ConfirmDatabaseId = 'Rutland County Council and Tarmac - Production';
        }
        else
        {
            //ConfirmUrl = 'https://development-connector.ondemand.confirm.co.uk/connectorwebservice/ConfirmConnector.asmx';
            ConfirmUrl = 'https://development-awswebservices.ondemand.confirm.co.uk/confirm/connector/confirmconnector.asmx';
            ConfirmPassword = 'Enquir1es';
            ConfirmDatabaseId = 'Rutland County Council and Tarmac - Development';
        }

        
        
        string body = '<?xml version="1.0" encoding="utf-8"?>';
        body = body + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
		body = body + '<soap12:Body>';
		body = body + '<ProcessOperationsRequest xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
		body = body + '<Request xmlns="">';
		body = body + '<Authentication>';
		body = body + '<Username>SFCRM</Username>';
		body = body + '<Password>'+ConfirmPassword+'</Password>';
		body = body + '<DatabaseId>'+ConfirmDatabaseId+'</DatabaseId>';
		body = body + '</Authentication>';
		body = body + '<Operation>';
		body = body + '<GetEnquiry>';
        body = body + '<EnquiryNumber>'+enquiryRef+'</EnquiryNumber>';
        body = body + '</GetEnquiry>';
		body = body + '</Operation>';
		body = body + '</Request>';
		body = body + '</ProcessOperationsRequest>';
		body = body + '</soap12:Body>';
		body = body + '</soap12:Envelope>';
        
        System.debug(body);
        
        
        req.setEndpoint(ConfirmUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('Charset', 'UTF-8');
		req.setTimeout(20000);
        req.setBody(body);
        //req.setCompressed(true);
        
        

        if(!Test.isRunningTest()) {
            // under  Test we cannot make web service call outs
            try {
                res = http.send(req);
            } catch(System.CalloutException e) {
                system.debug('---ERROR CALLING----');
                System.debug('Callout error: '+ e);
                System.debug(res.toString());
                system.debug('-------');
            }
        }
        else
        {
            res.setHeader('Content-Type', 'application/json');
            string testresult =  '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
            testresult = testresult + '<soap:Body>';
            testresult = testresult + '<ProcessOperationsResult xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
            testresult = testresult + '<Response SchemaVersion="1.4" xmlns="">';
            testresult = testresult + '<OperationResponse>';
            testresult = testresult + '<GetEnquiryResponse>';
            testresult = testresult + '<Enquiry>';
            testresult = testresult + '<EnquiryNumber>11000155</EnquiryNumber>';
            testresult = testresult + '<ExternalSystemNumber>1</ExternalSystemNumber>';
            testresult = testresult + '<ExternalSystemReference>FMS-RCC-00276_061220181233</ExternalSystemReference>';
            testresult = testresult + '<EnquiryX>486532.17</EnquiryX>';
            testresult = testresult + '<EnquiryY>309943.66</EnquiryY>';
            testresult = testresult + '<EnquiryLogNumber>2</EnquiryLogNumber>';
            testresult = testresult + '<EnquiryStatusCode>2800</EnquiryStatusCode>';
            testresult = testresult + '<EnquiryStatusName>Defect Found: 7 Day Priority</EnquiryStatusName>';
            testresult = testresult + '<AssignedOfficerCode>CUSE</AssignedOfficerCode>';
            testresult = testresult + '<AssignedOfficerName>Customer Services Default</AssignedOfficerName>';
            testresult = testresult + '<LoggedTime>2018-12-07T15:11:52</LoggedTime>';
            testresult = testresult + '<LogEffectiveTime>2018-12-07T15:11:48</LogEffectiveTime>';
            testresult = testresult + '<StatusFollowUpTime>2018-12-08T15:11:48</StatusFollowUpTime>';
            testresult = testresult + '<LoggedByUserName>Andy Nix</LoggedByUserName>';
            testresult = testresult + '<LoggedByUserId>RUTAR00030</LoggedByUserId>';
            testresult = testresult + '</Enquiry>';
            testresult = testresult + '</GetEnquiryResponse>';
            testresult = testresult + '</OperationResponse>';
            testresult = testresult + '</Response>';
            testresult = testresult + '</ProcessOperationsResult>';
            testresult = testresult + '</soap:Body>';
            testresult = testresult + '</soap:Envelope>';

            //XMLBODY <EnquiryNumber>TEST</EnquiryNumber>
            res.setBody(testresult);
        	res.setStatusCode(200);
		}   
        
        string result = res.getBody();
        system.debug('---ALL MESSAGE FROM CONFIRM ----');
        system.debug(result);
        system.debug('----END OF ALL MESSAGE FROM CONFIRM---');
        
        // send the result to the log object
        logEntry = logEntry + 'Web call result:' + result+'\r\n';
        
        
 /*
        string result;
        
        result = result + '<?xml version="1.0" encoding="utf-8"?>';
result = result + '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
    result = result + '<soap:Body>';
        result = result + '<ProcessOperationsResult xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">';
            result = result + '<Response SchemaVersion="1.4" xmlns="">';
                result = result + '<OperationResponse>';
                    result = result + '<GetNewEnquiryStatusChangesResponse>';
                        result = result + '<UpdatedEnquiry>';
                            result = result + '<EnquiryNumber>11000155</EnquiryNumber>';
                            result = result + '<ExternalSystemNumber>1</ExternalSystemNumber>';
                            result = result + '<ExternalSystemReference>FMS-RCC-00276_061220181233</ExternalSystemReference>';
                            result = result + '<EnquiryX>486532.17</EnquiryX>';
                            result = result + '<EnquiryY>309943.66</EnquiryY>';
                            result = result + '<EnquiryStatusLog>';
                                result = result + '<EnquiryLogNumber>2</EnquiryLogNumber>';
                                result = result + '<EnquiryStatusCode>2800</EnquiryStatusCode>';
                                result = result + '<EnquiryStatusName>Defect Found: 7 Day Priority</EnquiryStatusName>';
                                result = result + '<AssignedOfficerCode>CUSE</AssignedOfficerCode>';
                                result = result + '<AssignedOfficerName>Customer Services Default</AssignedOfficerName>';
                                result = result + '<LoggedTime>2018-12-07T15:11:52</LoggedTime>';
                                result = result + '<LogEffectiveTime>2018-12-07T15:11:48</LogEffectiveTime>';
                                result = result + '<StatusFollowUpTime>2018-12-08T15:11:48</StatusFollowUpTime>';
                                result = result + '<LoggedByUserName>Andy Nix</LoggedByUserName>';
                                result = result + '<LoggedByUserId>RUTAR00030</LoggedByUserId>';
                            result = result + '</EnquiryStatusLog>';
                        result = result + '</UpdatedEnquiry>';
                    result = result + '</GetNewEnquiryStatusChangesResponse>';
                result = result + '</OperationResponse>';
            result = result + '</Response>';
        result = result + '</ProcessOperationsResult>';
    result = result + '</soap:Body>';
result = result + '</soap:Envelope>';
*/       
        
        //result = result.replace('<GetNewEnquiryStatusChangesResponse />', '<GetNewEnquiryStatusChangesResponse/>');
        
        integer start = result.indexOf('<Enquiry>');
        integer finish = result.indexOf('</Enquiry>') + 10;
        
        
        result = result.mid(start, finish-start);
        
        system.debug('---MESSAGE FROM CONFIRM ----');
        System.debug(result);
        system.debug('----END OF MESSAGE FROM CONFIRM---');

        //XmlStreamReader xsr = new XmlStreamReader(res.getBody());
        //system.debug(xsr);
        //XmlStreamReader xsr1 = new XmlStreamReader(result);
        //system.debug(xsr1);

        DOM.Document doc=new DOM.Document();
        try
        {
            doc.load(result);
        }
        catch (Exception e)
        {
           // send the result to the log object
        logError = true;
        logEntry = logEntry + 'No valid XML loaded\r\n';
        }
        
   
        /*
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <soap:Body>
        <ProcessOperationsResult xmlns="http://www.confirm.co.uk/schema/am/connector/webservice">
            <Response SchemaVersion="1.4" xmlns="">
                <OperationResponse>
                    <GetNewEnquiryStatusChangesResponse>
                        <UpdatedEnquiry>
                            <EnquiryNumber>11000155</EnquiryNumber>
                            <ExternalSystemNumber>1</ExternalSystemNumber>
                            <ExternalSystemReference>FMS-RCC-00276_061220181233</ExternalSystemReference>
                            <EnquiryX>486532.17</EnquiryX>
                            <EnquiryY>309943.66</EnquiryY>
                            <EnquiryStatusLog>
                                <EnquiryLogNumber>2</EnquiryLogNumber>
                                <EnquiryStatusCode>2700</EnquiryStatusCode>
                                <EnquiryStatusName>Defect Found: 7 Day Priority</EnquiryStatusName>
                                <AssignedOfficerCode>CUSE</AssignedOfficerCode>
                                <AssignedOfficerName>Customer Services Default</AssignedOfficerName>
                                <LoggedTime>2018-12-07T15:11:52</LoggedTime>
                                <LogEffectiveTime>2018-12-07T15:11:48</LogEffectiveTime>
                                <StatusFollowUpTime>2018-12-08T15:11:48</StatusFollowUpTime>
                                <LoggedByUserName>Andy Nix</LoggedByUserName>
                                <LoggedByUserId>RUTAR00030</LoggedByUserId>
                            </EnquiryStatusLog>
                            <EnquiryStatusLog>
                                <EnquiryLogNumber>2</EnquiryLogNumber>
                                <EnquiryStatusCode>2700</EnquiryStatusCode>
                                <EnquiryStatusName>Defect Found: 7 Day Priority</EnquiryStatusName>
                                <AssignedOfficerCode>CUSE</AssignedOfficerCode>
                                <AssignedOfficerName>Customer Services Default</AssignedOfficerName>
                                <LoggedTime>2018-12-07T15:11:52</LoggedTime>
                                <LogEffectiveTime>2018-12-07T15:11:48</LogEffectiveTime>
                                <StatusFollowUpTime>2018-12-08T15:11:48</StatusFollowUpTime>
                                <LoggedByUserName>Andy Nix</LoggedByUserName>
                                <LoggedByUserId>RUTAR00030</LoggedByUserId>
                            </EnquiryStatusLog>
                        </UpdatedEnquiry>
                    </GetNewEnquiryStatusChangesResponse>
                </OperationResponse>
            </Response>
        </ProcessOperationsResult>
    </soap:Body>
</soap:Envelope>
*/
 try {
        DOM.XmlNode rootNode=doc.getRootElement();
        
        for (Dom.XMLNode child : rootNode.getChildElements()) {
            //system.debug(child.getName());
            if (child.getName() == 'EnquiryStatusCode')
                {
                system.debug('-----FOUND Status TO PROCESS----');
                system.debug(child.getText());
                UpdateFixMyStreet(enquiryRef,child.getText());
                }
            }
 	 }
     catch (Exception e)
     {
           // send the result to the log object
        logError = true;
        logEntry = logEntry + 'Could not parse xml\r\n';
     }
     
      if (logError)
      {
          ConfirmLogEntry(logEntry);
      }  
    
    }

    public static  void UpdateFixMyStreet(string enquiryref,string status)
    {
    // we have a enquiry ref and a confrim status so fist update the record
        

       	FixMyStreet__c[] fixmystreets = [SELECT id, Confirm_Status__c
                        FROM FixMyStreet__c 
                        WHERE ConfirmReference__c = :enquiryref
                        LIMIT 1
                       ];

        if (fixmystreets.size() == 0)
        {
            return;
        }

        FixMyStreet__c fixmystreet = fixmystreets[0];
        
       	//FixMyStreet__c fixmystreet;
        //fixmystreet = [SELECT id, Name, Service_Area__c,title__c,
        //               ConfirmReference__c, New_update_Comments__c, Update_FixMyStreet__c 
        //                FROM FixMyStreet__c 
        //                WHERE ConfirmReference__c = :enquiry
         //               LIMIT 1
         //             ];

        system.debug(fixmystreet);
        if (fixmystreet != null)
        {
            if (fixmystreet.Confirm_Status__c == status)
            {
            system.debug('----Current Confirm Status matches Salesforce no action required ---');
            }

            if (fixmystreet.Confirm_Status__c != status && fixmystreet.Confirm_Status__c !='')
            {
            system.debug('----Current Confirm Status does not match Salesforce ---');
            fixmystreet.Confirm_Status__c = status;

            FixMyStreet_Updates__mdt fms_Update;
            fms_Update = [SELECT MasterLabel, Update_Text__c, Closed__c, Fixed__c  FROM FixMyStreet_Updates__mdt WHERE MasterLabel = :status LIMIT 1];
            if (fms_Update != null)
                {
                string newComments = fms_Update.Update_Text__c;
                system.debug(newComments);
                fixmystreet.New_update_Comments__c = newComments;
                fixmystreet.Update_FixMyStreet__c = true;
                if (fms_Update.Closed__c == true)
                {
                    fixmystreet.Status__c = 'Closed';
                }
                if (fms_Update.Fixed__c == true)
                {
                    fixmystreet.Status__c = 'Fixed';
                }
                }
            upsert fixmystreet;
            }
        }
    }

    // run ConfirmWebService.testMe(); from Execute Anonymous to test
    //public static  void testMe() {
    //    sendGetEnquiryLookups();
    //}
    //public static  void testMe1() {
    //    GetEnquiryLookups('11000091');
    //}
    //public static  void testMe2() {
//		NewEnquiry();
  //  }
    
    
}