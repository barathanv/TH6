({
	onSearch : function(component, item, callback) {
		
        var action = component.get("c.getBoats");
        action.setParams({
            'boatTypeId': item
        });
        //console.log('action : ' + JSON.stringify(action));
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("SUCCESS response.getReturnValue(): " + response.getReturnValue());
                component.set("v.boatsList", response.getReturnValue());
                var objArray = response.getReturnValue();
                console.log('objArray.length()' + objArray.length + ' : ' + JSON.stringify(objArray[0])) ;
                if (objArray.length == 1 && JSON.stringify(objArray[0] )== "[]")
                    component.set("v.showBoats",false);
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