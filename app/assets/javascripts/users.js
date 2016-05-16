$(document).ready(function() {


	//alert($("#calendar").data('calendar'));

	//console.log($("#calendar").data('calendar') + "  LOGGED   ");


  function HandleBackFunctionality(event)
{

  //$("#calendar").load("http://localhost:3000/users/3 #calendar*","" );
	//console.log("refresh");


}

 //window.onunload = HandleBackFunctionality();

 // TODO how to only load the events with description "attend" on others' pages?
 // if user == authenticated user, show all event_commitments
 // else {
 //   show event_commitments where event_commitment.description is attend
 // }

 // path for calendar
	var path = "/users/" + $("#calendar").data('calendar') + ".json";

	//console.log(path);

	// fullCalendar configuration
	$('#calendar').fullCalendar({

		events : path,

		eventRender: function(event, element) {
      /* happens for each event individually */

			// make max name size 18 characters. Append 3 dots if name is longer than this
			var mod_name = event.event_name;
			var limit = 18;
			if (mod_name.length > limit) {
				mod_name = mod_name.substr(0,limit-3)+'...';
			}

      console.log(event);
      console.log(event.description);
      if (event.description == "watch") {
        element.css('background-color', 'blue');
        element.css('border-color', 'blue');
      } else if (event.description == "attend") {
        element.css('background-color', 'green');
        element.css('border-color', 'green');
      } else {  // other TODO remove this
        element.css('background-color', 'grey');
        element.css('border-color', 'grey');
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
