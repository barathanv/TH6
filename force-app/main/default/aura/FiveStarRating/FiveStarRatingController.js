({
	afterScriptsLoaded : function(component, event, helper) {
        console.log('5StarRating : afterScriptsLoaded');
         var domEl = component.find("ratingarea").getElement(); // [get dom element of rating area]
         console.log('domEl ' + domEl);
         var currentRating =  component.get("v.value"); //  [get value attribute of component]
          var readOnly = component.get("v.readonly"); 
    	  var maxRating = 5;
  		  var callback = function(rating) {
    	component.set('v.value',rating);
    	}
    	component.ratingObj = rating(domEl,currentRating,maxRating,callback,readOnly); 
        console.log('5StarRating ratingObj ' + ratingObj);
    },
    onValueChange: function(component,event,helper) {
        
        console.log('5StarRating : onValueChange');
         if (component.ratingObj) {
            var value = component.get('v.value');
            component.ratingObj.setRating(value,false);
        }
    }

})