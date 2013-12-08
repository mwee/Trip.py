//$(document).ready(function() {
  var ie = $( ".datepicker" )
  //if(ie.length > 0) {alert("here");}
  
   // alert( "freedates are "+ freedates );
	$( ".datepicker" ).datepicker(
	    {beforeShowDay: highlightFree} 
	);	
    function highlightFree(date) {
	     var year= date.getFullYear().toString();
		 var month= (date.getMonth()+1).toString();
		 if (month.length <= 1) {month="0"+ month.toString() ;}
		 var d= date.getDate().toString();
		 if (d.length <= 1) {d="0"+ d.toString() ;}
	     var date_formatted=year+"-"+month+"-"+d;
	     var contain=false;
	     if (freedates.indexOf(date_formatted.toString()) > -1 ) {
		    var contain=true ;
			}	     
        return [true, contain? 'free' : ''];
    }
//});

