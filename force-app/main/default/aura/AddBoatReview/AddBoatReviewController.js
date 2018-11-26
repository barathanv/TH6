({
    doInit : function(component, event, helper){
        // Prepare a new record from template
        console.log('Add review controller : doInit');
        component.find("service").getNewRecord(
            "BoatReview__c", // sObject type (entityAPIName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.boatReview");
                var error = component.get("v.recordError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }
                else {
                    var _boat = component.get("v.boat");
                    component.set("v.boatReview.Boat__c",_boat.Id);
                    console.log("Record template initialized: " + rec.sobjectType);
                }
            })
        );
    },
    onRecordUpdated : function(component, event, helper) {
        console.log('Add review controller : onRecordUpdated');
         var eventParams = event.getParams();
		console.log('eventParams.changeType: ' + eventParams.changeType);            
        if(eventParams.changeType === "CHANGED") {
            // get the fields that are changed for this record
            var changedFields = eventParams.changedFields;
            console.log('Fields that are changed: ' + JSON.stringify(changedFields));
            // record is changed so refresh the component (or other component logic)
            var resultsToast = $A.get("e.force:showToast");
            	if (resultsToast != null){
            		resultsToast.setParams({
                			"title": "Saved",
               			 "message": "The record was updated."
           				 });
            			resultsToast.fire();
                }else{
                    alert('The record was updated.');
                }
        } else if(eventParams.changeType === "LOADED") {
            console.log("Record is loaded successfully.");
            console.log('Boat Details : ' + JSON.stringify(component.get("v.boat")));
            var _boat = component.get("v.boat");
            component.set("v.id",_boat.Id);
        } else if(eventParams.changeType === "REMOVED") {
            var resultsToast = $A.get("e.force:showToast");
            if (resultsToast != null){
                resultsToast.setParams({
                	"title": "Deleted",
                	"message": "The record was deleted."
            		});
            	resultsToast.fire();
            }else{
                alert("The record was deleted.");
            }
            
        } else if(eventParams.changeType === "ERROR") {
            console.log('Error: ' + component.get("v.error"));
        }
    },
    onSave: function(component, event, helper) {
        
        console.log('Add review controller : onSave');
        //if(helper.validateContactForm(component)) {
        	//var _boat = component.get("v.boat");
            //component.set("v.boatReview.Boat__c",_boat.Id);
            //component.set("v.simpleNewContact.AccountId", component.get("v.recordId"));
            component.find("service").saveRecord(function(saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    if (resultsToast != null){
                    	resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    	});
                    	resultsToast.fire();
                    }
                    else{
                        alert("The record was saved.");
                    }
                    
                    var reviewAddedEvent = component.getEvent("BoatReviewAdded");
        			reviewAddedEvent.fire();
                    console.log('Add review controller : calling helper.onInit()');
                    helper.onInit(component);
                    console.log('Add review controller : after calling helper.onInit()');
                } else if (saveResult.state === "INCOMPLETE") {
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    component.set("v.recordError",saveResult.error);
                    console.log('Problem saving contact, error: ' + 
                                 JSON.stringify(saveResult.error));
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state +
                                ', error: ' + JSON.stringify(saveResult.error));
                }
            });
        }
})