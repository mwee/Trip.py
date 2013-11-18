// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// code to update the vote counts
$(document).ready(function() {
	$('.' + 'like_link').click(function() {
		var activity_id = $(this).attr('activity_id')
		var num_likes = $('#like_' + activity_id).html()
		$('#like_' + activity_id).html(parseInt(num_likes) + 1)
		location.reload()

	});


	$('.' + 'unlike_link').click(function() {
		var activity_id = $(this).attr('activity_id')
		var num_likes = $('#like_' + activity_id).html()
		$('#like_' + activity_id).html(parseInt(num_likes) - 1)
		location.reload()
	});
});
