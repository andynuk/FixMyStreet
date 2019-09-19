# Get the private key from the environment variable
echo "Setting up Production Connection..."
mkdir keys
echo $SFDC_SERVER_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
echo "Authenticating to DevHub..."
sfdx force:auth:jwt:grant --clientid $SFDC_PROD_CLIENTID --jwtkeyfile keys/server.key --username $SFDC_PROD_USER --setdefaultdevhubusername -a DevHub

#Deploy the package to UAT
echo "Deploy the package to UAT...."
echo "Name of Package Id...."
echo ${PACKAGEID}

echo "Find the latest version of the package"

PACKAGELIST=$(sfdx force:package:version:list --packages ${PACKAGEID} --json -v DevHub)
echo "reading packagelist"
echo ${PACKAGELIST}

echo "checking number of packages..."
NUMBEROFPACKAGES=$(echo $PACKAGELIST| jq  '.result | length') 
echo "number of packages"
echo ${NUMBEROFPACKAGES}
NUMBEROFPACKAGES=$NUMBEROFPACKAGES-1
echo "0 based number of package"
echo ${NUMBEROFPACKAGES}

echo "attempt to reading latest package id"
LATESTPACKAGE=$(echo $PACKAGELIST| jq --raw-output .result[$NUMBEROFPACKAGES].SubscriberPackageVersionId) 
echo "reading latest package"
echo ${LATESTPACKAGE}


echo "Deploy the package to UAT..."
sfdx force:package:install -p ${LATESTPACKAGE} -u UAT -w 10 -r
