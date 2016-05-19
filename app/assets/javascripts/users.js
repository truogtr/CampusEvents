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

      // TODO make these colors line up with app style
      var blue_light = "#5486c2";
      var blue_darker = "#2e5481";
      // TODO this way of assigning the colors works...but is there a way to
      // change the colors by assigning each element to a class that we
      // can modify in events.css.scss?
      if (event.description == "watch") {
        // element.classed('watched_event');
        element.css('background-color', blue_light);
        element.css('border-color', blue_light);
      } else if (event.description == "attend") {
        // element.classed('attended_event');
        element.css('background-color', blue_darker);
        element.css('border-color', blue_darker);
      } else {  // other TODO remove this
        element.css('background-color', 'grey');
        element.css('border-color', 'grey');
      }

      element.find('.fc-title').append("<br/>" + mod_name);
    },

    header: {
                     left: 'title',
                     center: 'agendaDay,agendaWeek,month',
                     right: 'today prev,next'
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
