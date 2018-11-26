({
	onBoatSelected1  : function(component, event, helper) {
        console.log('BoatDetailsController : onBoatSelected');
        var _boat = event.getParam('boat');
        console.log('BoatDetailsController : onBoatSelected' + _boat);
        component.set("v.id",_boat.Id);
        component.set('v.boat' , _boat);
		component.find("service").reloadRecord(true) ;
        
	}//onBoatSelected 
    ,
    onBoatSelected : function(component, event, helper) {
        console.log("Boat Details Controller : onBoatSelected");
        var boatSelected = event.getParam("boat");

        component.set("v.id",boatSelected.Id);

        var service = component.find("service");

        service.reloadRecord() ;

    }
    ,
    
    onRecordUpdated : function(component, event, helper) {
         var eventParams = event.getParams();
		console.log('eventParams.changeType: ' + eventParams.changeType);            
        if(eventParams.changeType === "CHANGED") {
            // get the fields that are changed for this record
            var changedFields = eventParams.changedFields;
            console.log('Fields that are changed: ' + JSON.stringify(changedFields));
            // record is changed so refresh the component (or other component logic)
            var resultsToast = $A.get("e.force:showToast");
            resultsToast.setParams({
                "title": "Saved",
                "message": "The record was updated."
            });
            resultsToast.fire();
        } else if(eventParams.changeType === "LOADED") {
            console.log("Record is loaded successfully.");
            console.log('Boat Details : ' + JSON.stringify(component.get("v.boat")));
            var _boat = component.get("v.boat");
            component.set("v.id",_boat.Id);
        } else if(eventParams.changeType === "REMOVED") {
            var resultsToast = $A.get("e.force:showToast");
            resultsToast.setParams({
                "title": "Deleted",
                "message": "The record was deleted."
            });
            resultsToast.fire();
        } else if(eventParams.changeType === "ERROR") {
            console.log('Error: ' + component.get("v.error"));
        }
        var childComp = component.find("boatReviewsCmp");
        if (childComp != null){
        	console.log('childComp : BoatDetailsController' + childComp );
        	childComp.refresh();
         }
    },
    
    doInit : function(component, event, helper){
        console.log('BoatDetailsController : doInit');
        component.set("v.id","a055A00000oF9ByQAK");
        component.find("service").set("v.recordId","a055A00000oF9ByQAK");
        console.log('component.find(service)' + component.find("service"));
        component.find("service").reloadRecord() ;
        console.log('Boat Details : doInit' + JSON.stringify(component.get("v.boat")));
    },
    
    onBoatReviewAdded : function(component, event, helper){
        
        console.log('BoatDetailsController : onBoatReviewAdded');
        component.find("tabs").set("v.selectedTabId","boatreviewtab");
        var childComp = component.find("boatReviewsCmp");
        console.log('childComp : BoatDetailsController' + childComp );
        childComp.refresh();
    }
    
})