$(document).ready(function() {


	//alert($("#calendar").data('calendar'));

	//console.log($("#calendar").data('calendar') + "  LOGGED   ");


  function HandleBackFunctionality(event)
{
	
  //$("#calendar").load("http://localhost:3000/users/3 #calendar*","" );
	//console.log("refresh");
  

}

 //window.onunload = HandleBackFunctionality();

 // path for calendar
	var path = "/users/" + $("#calendar").data('calendar') + ".json";

	//console.log(path);

	// fullCalendar configuration
	$('#calendar').fullCalendar({

		events : path,

		eventRender: function(event, element) {

			// make max name size 18 characters. Append 3 dots if name is longer than this
			var mod_name = event.event_name;
			var limit = 18;
			if (mod_name.length > limit) {
				mod_name = mod_name.substr(0,limit)+'...';
			}


      element.find('.fc-title').append("<br/>" + mod_name); 
    },

    views: {
      month: { // name of view
            //titleFormat: 'YYYY, MM, DD'
            // other view-specific options here
        displayEventEnd: true
      }
   	}

  });

});