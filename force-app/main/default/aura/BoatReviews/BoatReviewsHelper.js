({
	onInit : function(component,item,callback) {
		
        console.log('BoatReviewController Helper : onInit');
        var action = component.get("c.getAll");
        action.setParams({
            'boatId': item.Id
        });
        //console.log('action : ' + JSON.stringify(action));
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("SUCCESS response.getReturnValue(): " + response.getReturnValue());
                component.set("v.boatReviews", response.getReturnValue());
                var objArray = response.getReturnValue();
                console.log('objArray.length()' + objArray.length + ' : ' + JSON.stringify(objArray)) ;
                if (objArray.length == 0 )
                    component.set("v.showReviews",false);
            }
            else {
                console.log("Failed with state: " + state);
                console.log("Failed with response: " + response.getReturnValue());
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
        
	}
})