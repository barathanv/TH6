({
	onBoatClick : function(component, event, helper) {
		
        var boatSelectedEvent2 =  $A.get('e.c:BoatSelected'); //component.getEvent("boatSelected"); // $A.get('e.c:BoatSelected'); 
        console.log('event boatSelect2 : ' + boatSelectedEvent2);
        /*var target2 = event.getSource();
        var boatId2  = target2.get("v.name") ;
        console.log("boatId : " + boatId2);*/
        var _boat = component.get("v.boat");
        boatSelectedEvent2.setParams({ "boat": _boat}); 
        console.log("_boat : " + JSON.stringify(_boat));
        boatSelectedEvent2.fire();
        console.log("boatSelectedEvent2 fired : " + JSON.stringify(boatSelectedEvent2.getParams('boat')));
        
        var boatSelectedEvent = component.getEvent("boatSelect");
        console.log('event : ' + boatSelectedEvent);
        var target = event.getSource();
        console.log('event : ' + (event));
        var boatId  = target.get("v.name") ;
        $A.util.addClass(target,"selected");
        console.log("boatId : " + boatId);
        boatSelectedEvent.setParams({ "boatId": boatId}); 
        boatSelectedEvent.fire();
        
        var plotBoatLocationEvent =  $A.get('e.c:PlotMapMarker');
        var strLat = String(_boat.Geolocation__Latitude__s);
         //console.log('strLat : ' + strLat);
        //console.log('_boat.Geolocation__Longitude__s : ' + (_boat.Geolocation__Longitude__s));
        plotBoatLocationEvent.setParams({
            'lat' :  String(_boat.Geolocation__Latitude__s), 
            'long' :  String(_boat.Geolocation__Longitude__s),
            'label' : _boat.Name,
            'sObjectId' : _boat.Id
        });
        console.log("plotBoatLocationEvent fired : " + JSON.stringify(plotBoatLocationEvent.getParams('lat')));
        plotBoatLocationEvent.fire();
        
	}
})