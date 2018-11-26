({
    jsLoaded: function(component) {
        component.set("v.jsLoaded", true);
    }  
    ,
    onMarkLocation : function(component, event, helper){
        console.log('MapController onMarkLocation');
        console.log('MapController onMarkLocation'  + JSON.stringify(event));
        var paramObj = event.getParams('arguments');
        var paramLat = event.getParam('lat');
        console.log('MapController onMarkLocation paramLat' + paramLat);
        var paramLong =  event.getParam('long');
        var paramLabel =  event.getParam('label');
        var paramObjID =  event.getParam('sObjectId');
        var objLocation = {'lat':paramLat, 'long':paramLong};
        component.set('v.location',objLocation);
        
    }
})