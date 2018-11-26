({
    onBoatSelect : function(component, event, helper){
        var _boatId = event.getParam('boatId');
        console.log('BSRC: BoatTile Selected event _boatId' + _boatId);
        console.log('BSRC: BoatTile Selected event _boatId' + _boatId);
        component.set("v.selectedBoatId",_boatId);
        var arr = [];
    	arr = component.find(_boatId);
        console.log('arr btn : ' + arr);
        for(var cmp in arr) {
            //if (cmp.get("v.name") == _boatId)
        	//$A.util.addClass(arr[cmp], "tile selected");
            console.log('cmp btn : ' + cmp  );
    	}
    	 var targetElement = event.target;
    	 $A.util.addClass(targetElement,"selectedRow");
        
    }//onBoatSelect
    ,
    
    doSearch : function(component, event, helper) {
		
        
        console.log('BSRC event ' + JSON.stringify(event));
        var params = event.getParam('arguments');
        var _boatTypeId =  params.boatTypeId;
         console.log('BSRC event _boatTypeId' + _boatTypeId);
        
        helper.onSearch(component, _boatTypeId );
        /*
        var action = component.get("c.getBoats");
        action.setParams({
            'boatTypeId': _boatTypeId
        });
        //console.log('action : ' + JSON.stringify(action));
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("SUCCESS response.getReturnValue(): " + response.getReturnValue());
                component.set("v.boatsList", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
                console.log("Failed with response: " + response.getReturnValue());
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
        */
	}
})