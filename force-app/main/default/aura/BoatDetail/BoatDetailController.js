({
	doInit : function(component, event, helper) {
		
        component.set("v.showButton", $A.get("e.force:navigateToSObject"));
	},
    
    onFullDetails : function(component, event, helper){
        
        var navigateEvent  = $A.get("e.force:navigateToSObject");
        var _boat = component.get("v.boat");
        console.log("_boat : " + _boat);
       
        navigateEvent.setParams({'entityApiName':'Boat__c', 'defaultFieldValues': { 'recordId':_boat.Id} }); 
        navigateEvent.fire();
    }
})