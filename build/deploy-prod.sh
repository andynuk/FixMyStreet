<<<<<<< HEAD

#Deploy the package to Production
echo "Deploy the package to Production...."
=======
#Deploy the package to Production
#only works if package released - see sfdx force:package:version:promote -p 04t1n0000021k4ZAAQ
echo "Deploy to Production...."
>>>>>>> 5d77469a36a4a6c86676d6e6b50ffcb67cb13e9e
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


echo "Deploy the package to Production..."
sfdx force:package:install -p ${LATESTPACKAGE} -u DevHub -w 10  
