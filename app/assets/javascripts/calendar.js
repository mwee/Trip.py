$(document).ready(function() {

	$(".datepicker").each(function() {
		var dates = $(this).attr("data_dates").split(',');
		$(this).datepicker({
			beforeShowDay : function(date) {
				return highLightSelected(date, dates)
			}
		});

	});

	//highlight date if date is in dates
	function highLightSelected(date, dates) {
		var year = date.getFullYear().toString();
		var month = (date.getMonth() + 1).toString();
		if (month.length <= 1) {
			month = "0" + month.toString();
		}
		var d = date.getDate().toString();
		if (d.length <= 1) {
			d = "0" + d.toString();
		}
		var date_formatted = year + "-" + month + "-" + d;
		var contain = false;
		if (dates.indexOf(date_formatted.toString()) > -1) {
			var contain = true;
		}
		return [true, contain ? 'free' : ''];
	}

});

