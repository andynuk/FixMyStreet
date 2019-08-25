({
	DoInit : function(component, event, helper) {
		// get the logged in user from the currentUserId
        //var userId = $A.get("$SObjectType.CurrentUser.Id");
        //console.log(userId);
       //component.set("v.UserId",userId);
        // reload the record
        //component.find("UserRecordService").reloadRecord();



        console.log("Community Report Issues DoInit being called");
        var action = component.get("c.GetFixMyStreetExtends");
        var params = { 
            "FixMyStreetId": component.get("v.FixMyStreetId")
        };
        console.log(params);
        action.setParams(params);        
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var retFixMyStreetExtends = a.getReturnValue();
            console.log(" Returned :",retFixMyStreetExtends);
            if (retFixMyStreetExtends != null)
                {
                    component.set("v.retFixMyStreetExtends",retFixMyStreetExtends);
                    
 
            var j = 0;
            var elementsFixMyStreetExtends = [];
            console.log("Setting up additional controls");
            console.log("Controls to process :",retFixMyStreetExtends.length);
            var retObj = JSON.parse(retFixMyStreetExtends);
            while (j < retObj.length)
            {
             var indFixMyStreet = retObj[j];
		console.log("Processing : ",indFixMyStreet);
		console.log("Check : ",indFixMyStreet.label);
        if (indFixMyStreet.fieldType == "text")
            {
                elementsFixMyStreetExtends.push(indFixMyStreet.name);
                $A.createComponent(
                    "lightning:input",
                    {
                        "label": indFixMyStreet.label,
                        "aura:id" : indFixMyStreet.name
                    },
                    function(newControl, status, errorMessage){
                        //Add the new element to the body array
                        if (status === "SUCCESS") {
                            console.log("success in creating component");
                            var body = component.get("v.body");
                            body.push(newControl);
                            component.set("v.body", body);
                        }
                        else if (status === "INCOMPLETE") {
                            console.log("No response from server or client is offline.")
                            // Show offline error
                        }
                        else if (status === "ERROR") {
                            console.log("Error: " + errorMessage);
                            // Show error message
                        }
                    }
                   );
	            }

        if (indFixMyStreet.fieldType == "options")
            {
                $A.createComponents(
                    [
                        ["lightning:select",
                        {
                            "label": indFixMyStreet.label,
                            "aura:id" : indFixMyStreet.name
                        }],
                        [
                            "option", { value: indFixMyStreet.optionsList[0], label: indFixMyStreet.optionsList[0] }
                        ],
                        [
                            "option", { value: indFixMyStreet.optionsList[1], label: indFixMyStreet.optionsList[1] }
                        ],
                        [
                            "option", { value: indFixMyStreet.optionsList[2], label: indFixMyStreet.optionsList[2] }
                        ],
                        [
                            "option", { value: indFixMyStreet.optionsList[3], label: indFixMyStreet.optionsList[3] }
                        ]
                     ],
                    function(newControl, status, errorMessage){
                        //Add the new element to the body array
                        if (status === "SUCCESS") {
                            console.log("success in creating component");
                            var body = component.get("v.body");
                            newControl[0].set("v.body", [newControl[1],newControl[2],newControl[3],newControl[4]]);
                            body.push(newControl[0]);
                            component.set("v.body", body);
                        }
                        else if (status === "INCOMPLETE") {
                            console.log("No response from server or client is offline.")
                            // Show offline error
                        }
                        else if (status === "ERROR") {
                            console.log("Error: " + errorMessage);
                            // Show error message
                        }
                    }
                   );
	            }


                
            j++;
			}                    
             // finally set the list of elements
             console.log('Setting elementsFixMyStreetExtends',elementsFixMyStreetExtends);
             component.set("v.elementsFixMyStreetExtends",elementsFixMyStreetExtends);       
                    
                    
                }
            });
        console.log('Queuing the action');
        $A.enqueueAction(action);	
    },
 
   /*
    handleUserLoaded : function(component, event, helper) {
    
        console.log("HandleUserLoaded being called");
        // this is  controller call
        var action = component.get("c.GetUserId");
                
        // do call back to server
        action.setCallback(this,function(a) {
        	console.log("returned from call back");
        	var retContact = a.getReturnValue();
        console.log("Contact Returned :",retContact);
        if (retContact != null)
            {
                component.set("v.myContact",retContact);
            } 
        });
       $A.enqueueAction(action);
        
    },
    */
    
    handleClick : function(component, event, helper) {
    
        // disabel the button
        let button = component.find('submit');
    	button.set('v.disabled',true);
        
        component.set('v.submitmessage','Please wait whilst the record is created.');
   
         var FixMyStreetId = component.get("v.FixMyStreetId");
         //var myContact = component.get("v.myContact");
         var lat = component.get("v.Lat");
         var long = component.get("v.Long");
        
	var retFixMyStreetExtends = component.get("v.retFixMyStreetExtends");  
        
			var newFixMyStreet;
        newFixMyStreet ='{"Service_Area__c" : "' + FixMyStreetId + '" , ';
        newFixMyStreet = newFixMyStreet + '"lat__c" : ' + lat.toString() + ' , ';
        newFixMyStreet = newFixMyStreet + '"long__c" : ' + long.toString() + ' , ';
               
        
            var retObj = JSON.parse(retFixMyStreetExtends);
        	var j = 0;
            while (j < retObj.length)
            {
             	console.log(j);
	             var indFixMyStreet = retObj[j];
				 var nameindFixMyStreet = indFixMyStreet.name;                
                 var valueindFixMyStreet = component.find(indFixMyStreet.name).get('v.value');
			console.log("field : ",indFixMyStreet.name);
			console.log("value : ",valueindFixMyStreet);
	
                 newFixMyStreet = newFixMyStreet + '"'+nameindFixMyStreet+'" : "' + valueindFixMyStreet + '"';
                if (j+1<retObj.length)
                {
                newFixMyStreet = newFixMyStreet + ' , ';
                }
                else
                {
                    newFixMyStreet = newFixMyStreet + '}';
                }
                    
               j++;
            }
 			console.log(newFixMyStreet);
                
            
        console.log('starting server call');
        var action = component.get("c.createNewFixMyStreet");
        console.log('Setting params');
        action.setParams({ newRecord : newFixMyStreet });
        console.log('Setting Call back');
        // do call back to server
        action.setCallback(this,function(a) {
            console.log("returned from call back");
            var ret = a.getReturnValue();
            // shoudl be the returned new fixmystreet reference
            console.log(" Returned :",ret);
            if (ret == "Error")
                {
                var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": "The FixMyStreet record has NOT Been created.",
						 "mode": "sticky",
                        "type" : "error"
                    });
                    toastEvent.fire();
		        component.set("v.submitmessage","Error on record create");
                component.set("v.Confirmed","true");
                }
            else
                {
                    var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Success!",
                            "message": "The FixMyStreet record has been created.",
							 "mode": "sticky",
                            "type": 'success'
                        });
                        toastEvent.fire();
                console.log("newFixMyStreet set");
                var check = component.get("v.newFixMyStreetId"); 
                component.set("v.Confirmed","true");
		        component.set("v.submitmessage","");
                console.log(check);
                console.log('End');
                }
            component.set("v.newFixMyStreetId",ret);
            component.set("v.returnId",ret);
            });
        console.log('Queuing the action');
        $A.enqueueAction(action);       
        
        
        
        
      //component.set("v.FixMyStreetId",FixMyStreetId);
//      var navigate = component.get('v.navigateFlow')
//      navigate('NEXT');
   
    },

    handle1Click : function(component, event, helper) {
     
      var navigate = component.get('v.navigateFlow')
      navigate('NEXT');

    },
})