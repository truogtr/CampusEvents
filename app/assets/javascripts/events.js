


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


	// change button text when attend button is clicked
	$('#attend').on("click", function() {
		var button_text = document.getElementById("attend");
	  if (button_text.value=="Attend Event") button_text.value = "Unattend Event";
	  else button_text.value = "Attend Event";


	// TODO change here to have three buttons: attend, watch, neither;
	// and change their color to blue with white text when selected.

 });



});
