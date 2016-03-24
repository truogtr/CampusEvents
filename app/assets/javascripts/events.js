


$(document).ready(function() {


window.onbeforeunload = function() { 

	//$('#calendar').fullCalendar('removeEvents');
	//$('#calendar').fullCalendar('addEventSource', "http://localhost:3000/users/3.json");
	//$('#calendar').fullCalendar('refetchEvents');


	//$("#calendar").fullCalendar( 'refetchEvents' );
	//$("#calendar").fullCalendar( 'refresh' );

	console.log("Your work will be lost."); 

};



	$('#attend').on("click", function() { 
		var button_text = document.getElementById("attend");
	  if (button_text.value=="Attend Event") button_text.value = "Unattend Event";
	  else button_text.value = "Attend Event";

 });



}); 
