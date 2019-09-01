global with sharing class FixMyStreetCommentsEmail {

	@InvocableMethod(label='FixMyStreet Comments Email' description='Used to send emails when comment')
    public static void doEmail(List<FMSRequests> requests) {

        
        if (requests == null)
       {
           system.debug('No id sent to doCreationConfirmRecord');
           return;
       }

        FMSRequests firstRequest = requests[0];
        
       Id fixmystreetId = firstRequest.fixmystreetId;
       String emailAddress = firstRequest.emailAddress;
       system.debug('NewEmail '+ fixmystreetId);
        SendEmail(fixmystreetId,emailAddress);
    }

    
    global  class FMSRequests {
        @InvocableVariable
        global Id fixmystreetId;
        @InvocableVariable
        global string emailAddress;
    }

    public static void SendEmail(Id fixmystreetId, string emailAdress) {

    // this is the Id of the comment
    FixMyStreet_Comments__c commentDetail = [SELECT FixMyStreet__c, Comment__c,Comment_Date__c FROM FixMyStreet_Comments__c where Id =: fixmystreetId LIMIT 1];

    string comment = '';
    string fmsSummary = '';
	FixMyStreet__c fixmystreet = null;
    if (commentDetail != null)
        {
        comment = commentDetail.Comment__c;
 
        fixmystreet = [SELECT id, Name, Service_Area__c,title__c,Description__c,Easting__c, Northing__c,
                        requested_datetime__c,Contact_Name__c,Contact_Phone__c,Contact_Email__c,
                       lat__c, long__c,
                        Location__c, SiteCode__c,
                       ConfirmReference__c,service_request_id__c,Number_of_Photos__c,FixMyStreetURL__c
                        FROM FixMyStreet__c 
                        WHERE FixMyStreet__c.id = :commentDetail.FixMyStreet__c
                        LIMIT 1
                       ];
        if (fixmystreet != null)
            {
            if (fixmystreet.ConfirmReference__c!='')
            {
            fmsSummary = fmsSummary + 'Confirm Reference: '+fixmystreet.ConfirmReference__c+'<br/>';
            }
            fmsSummary = fmsSummary + 'Reference: '+fixmystreet.Name+'<br/>';
             fmsSummary = fmsSummary + 'Title: '+fixmystreet.title__c+'<br/>';
            fmsSummary = fmsSummary + 'Link: '+fixmystreet.FixMyStreetURL__c+'<br/>';
            } 
        }

    // First, reserve email capacity for the current Apex transaction to ensure
    // that we won't exceed our daily email limits when sending email after
    // the current transaction is committed.
    Boolean proceed = false;
    try {
    Messaging.reserveSingleEmailCapacity(2);
    proceed = true;
    } catch (Exception e) {
        //handle your exception gracefully
    }
    // Processes and actions involved in the Apex transaction occur next,
    // which conclude with sending a single email.

    if (proceed)
    {
    // Now create a new single email message object
    // that will send out a single email to the addresses in the To, CC & BCC list.
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    // Strings to hold the email addresses to which you are sending the email.
    String[] toAddresses = new String[] {'anix@rutland.gov.uk'}; 
    String[] ccAddresses = new String[] {'anix@rutland.gov.uk'};

    string orgId = UserInfo.getOrganizationId();
    system.debug('OrgId: '+orgId);
    boolean production = false;
    if (orgId == '00D0Y000002EzYY')
    {
    production = true;
    }

    if (fixmystreet != null && production == true)
    {
        if (fixmystreet.ConfirmReference__c!=''){
                toAddresses.add('rsalt@rutland.gov.uk');
            }
        else {
                toAddresses.add('bthompson@rutland.gov.uk');
                toAddresses.add('mloran@rutland.gov.uk');
                toAddresses.add('skidd@rutland.gov.uk');
            }
    }
 

    // Assign the addresses for the To and CC lists to the mail object.
    mail.setToAddresses(toAddresses);
    mail.setCcAddresses(ccAddresses);

    // Specify the address used when the recipients reply to the email. 
    mail.setReplyTo('anix@rutland.gov.uk');

    // Specify the name used as the display name.
    mail.setSenderDisplayName('Salesforce');

    // Specify the subject line for your email address.
    mail.setSubject('New Comment on FixMyStreet Entry');

    // Set to True if you want to BCC yourself on the email.
    mail.setBccSender(false);

    // Optionally append the salesforce.com email signature to the email.
    // The email address of the user executing the Apex Code will be used.
    mail.setUseSignature(false);

    // Specify the text content of the email.
    mail.setPlainTextBody('FixMyStreet Details'+fmsSummary+'Comments'+ comment);

    mail.setHtmlBody('<b>FixMyStreet Details</b><br/>'+fmsSummary+'<b>Comments</b><br/>'+ comment);

    // Send the email you have created.
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    }
}