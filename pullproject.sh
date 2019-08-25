rm -R force-app/main/default
rm -R mdapipackage
mkdir mdapipackage
sfdx force:mdapi:retrieve -r mdapipackage/retrieve -p 'FixMyStreet Export 0.01' -u anix-rv7r@force.com
unzip mdapipackage/retrieve/unpackaged.zip -d mdapipackage
sfdx force:mdapi:convert -r 'mdapipackage/FixMyStreet Export 0.01'
rm -R mdapipackage
