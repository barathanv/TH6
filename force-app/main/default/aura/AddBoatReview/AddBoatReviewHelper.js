({
	onInit : function(component, event, callback) {
		
        console.log('Add review Helper : OnInit');
        /*var _boat  = component.get("v.boat");
        console.log('Add review Helper : OnInit : _boat' + _boat);
        var objboatReview=  { 'sobjectType': 'BoatReview__c',
                    'Name': '',
                    'Boat__c': _boat.Id,
                    'Comment__c': '' };
                    
        component.set("v.boatReview",objboatReview);
        console.log('objboatReview : ' + JSON.stringify(objboatReview));
        */
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
	}
})