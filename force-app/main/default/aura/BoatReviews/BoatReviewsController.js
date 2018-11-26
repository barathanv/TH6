({
	doInit : function(component, event, helper) {
		
        console.log('BoatReviewController : doInit');
        var item = component.get("v.boat");
        helper.onInit(component,item);
        
	}
    ,
    onUserInfoClick : function(component, event, helper){
        console.log('BoatReviewController : onUserInfoClick');
    	var usrId = event.currentTarget.getAttribute("data-userid");
        var nav2UserObjEvt = $A.get("e.force:navigateToSObject");
        nav2UserObjEvt.setParams({
            "recordId" : usrId,
        });
        nav2UserObjEvt.fire()
        console.log('BoatReviewController : onUserInfoClick fired ' + usrId);
	}
})