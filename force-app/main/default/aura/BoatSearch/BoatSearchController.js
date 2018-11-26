({
	onFormSubmit : function(component, event, helper) {
		console.log('onFormSubmit : BoatSearchController'  );
        var objParam = event.getParam("formData");
        console.log('objParam : BoatSearchController' + JSON.stringify(objParam)  );
        
        var childComp = component.find("cmpBoatSrchResultsID");
        console.log('childComp : BoatSearchController' + childComp );
        childComp.search(objParam.boatTypeId);
	}
})