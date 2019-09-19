# How to install


## Part 1: Setting up scracth org

sfdx force:org:create --setdefaultusername --setalias Alias --definitionfile config/project-scratch-def.json -d 30 -s

## In the org:
- Authorise org wide email address anix@rutland.gov.uk

### Command Line:
sfdx force:source:push

To get the oauth key for postman calls etc
sfdx force:org:display -u Scratchorg --verbose

### Export and Import Data
sfdx force:data:tree:export --outputdir data --prefix export --query "SELECT Id,Name,Image__c,Internal_Service_Area__c,InternalQueue__c, Live__c,Send_to_Confirm__c,Service_Code__c FROM FixMyStreetCategories__c" -u RCCHUb --plan
sfdx force:data:tree:export --outputdir data --prefix export --query "SELECT Id,Confirm_Service_Code__c,Confirm_Subject_Code__c,FieldValue__c,SecondField__c FROM FixMyStreetToConfirm__c" -u RCCHUb --plan

sfdx force:data:tree:import -u FixMyStreetScratch1  --plan data/export-FixMyStreetCategories__c-plan.json
sfdx force:data:tree:import -u FixMyStreetScratch1  --plan data/export-FixMyStreetToConfirm__c-plan.json


### In the Org (post successful push)

Assign 'FisMyStreet Permissions' permission set to the logged in user

manually change FixMyStreetToConfirm table to link to service areas

### More...

