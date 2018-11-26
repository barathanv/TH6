({
	doInit : function(component, event, helper) {
        
        var createRecordEvent = $A.get("e.force:createRecord");
        console.log("createRecordEvent : " + createRecordEvent);
        if (createRecordEvent == null){
            component.set("v.showNewBtn",false);
        }
        // Create the action
        var action = component.get("c.getBoatTypes");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("response.getReturnValue(): " + response.getReturnValue());
                component.set("v.boattypes", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
        
		
	}//doInit 
    ,
    openCreateBoatForm : function(component, event, helper){
    
        var createRecordEvent = $A.get("e.force:createRecord");
        var _boatType = component.find("idBoatType").get("v.value");
        console.log("_boatType : " + _boatType);
        if (_boatType != "0"){
        createRecordEvent.setParams({'entityApiName':'Boat__c', 'defaultFieldValues': { 'BoatType__c':_boatType} }); 
        }
        else{
         createRecordEvent.setParams({'entityApiName':'Boat__c'}); 
        }
        createRecordEvent.fire();
        
    }//openCreateBoatForm
    ,
    onFormSubmit : function(component, event, helper){
        console.log('onSearchFormSubmit');
        var _boatType = component.find("idBoatType").get("v.value"); 
        var searchEvent = component.getEvent("formsubmit");
        searchEvent.setParams( { 'formData': { 'boatTypeId' :_boatType }});
        searchEvent.fire();
        
    }//onFormSubmit
})