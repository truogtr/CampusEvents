


$(document).ready(function() {


//back-button stuff: doesn't work
window.onbeforeunload = function() {

	//$('#calendar').fullCalendar('removeEvents');
	//$('#calendar').fullCalendar('addEventSource', "http://localhost:3000/users/3.json");
	//$('#calendar').fullCalendar('refetchEvents');


	//$("#calendar").fullCalendar( 'refetchEvents' );
	//$("#calendar").fullCalendar( 'refresh' );

	//console.log("Your work will be lost.");

};


	/* change button text and class when attend button is clicked */
	var attend_button = document.getElementById("attend");
	console.log(attend_button);
	var watch_button = document.getElementById("watch");
	var neither_button = document.getElementById("neither");

	$('#attend').on("click", function() {
	  if (attend_button.className!="selected_button") {
			/* set selected button */
			attend_button.className = "selected_button";
			watch_button.className = "unselected_button";
			neither_button.className = "unselected_button";
			/* set text */
			attend_button.value = "Attending";
			watch_button.value = "Watch";
			neither_button.value = "Neither";

			console.log("attend_button.className: " + attend_button.className);
		}
	});

	$('#watch').on("click", function() {
	  if (watch_button.className!="selected_button") {
			/* set selected button */
			attend_button.className = "unselected_button";
			watch_button.className = "selected_button";
			neither_button.className = "unselected_button";
			/* set text */
			attend_button.value = "Attend";
			watch_button.value = "Watching";
			neither_button.value = "Neither";

			console.log("watch_button.className: " + watch_button.className);
		}
	});

	$('#neither').on("click", function() {
	  if (neither_button.className!="selected_button") {
			/* set selected button */
			attend_button.className = "unselected_button";
			watch_button.className = "unselected_button";
			neither_button.className = "selected_button";
			/* set text */
			attend_button.value = "Attend";
			watch_button.value = "Watch";
			neither_button.value = "Neither";
		}
	});

});
