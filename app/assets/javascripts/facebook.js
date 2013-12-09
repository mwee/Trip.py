$(document).ready(function() {
	//remove hash after facebook redirect
	if (window.location.hash && window.location.hash == '#_=_') {
		if (window.history && history.pushState) {
			window.history.pushState("", document.title, window.location.pathname);
		} else {
			// Prevent scrolling by storing the page's current scroll offset
			var scroll = {
				top : document.body.scrollTop,
				left : document.body.scrollLeft
			};
			window.location.hash = '';
			// Restore the scroll offset, should be flicker free
			document.body.scrollTop = scroll.top;
			document.body.scrollLeft = scroll.left;
		}
	}

	//initialize facebook sdk
	window.fbAsyncInit = function() {
		FB.init({
			appId : '1375015546079605', // App ID
			status : false, // check login status
			cookie : true, // enable cookies to allow the server to access the session
			xfbml : true, // parse XFBML
			channelUrl : 'https://infinite-beyond-7744.herokuapp.com/home/fbchannel',
			oauth : true,
		});

	}; ( function(d) {
			var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement('script');
			js.id = id;
			js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			ref.parentNode.insertBefore(js, ref);
		}(document));

	$("#invite").click(function() {
		FB.ui({
			
			method : 'apprequests',
			message : 'I am already using Trippy. Please join me.',
			display: 'popup',
		}, function(response) {
			console.log("finished");

			var request = response.request;
			var from = $("#user_data").attr("data_user_id");
			$.ajaxSetup({
				headers : {
					'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
				}
			});
			for (var i = 0; i < response.to.length; i++) {
				var to = response.to[i];
				console.log(request + " " + from + " " + to);
				$.ajax({
					type : "POST",
					url : "/friendships/create",
					beforeSend : function(xhr) {
						xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
					},
					data : {
						user_id : from,
						friend_uid : to,
					},
					success : function() {
						console.log("Data Send!");
					},
					error : function(xhr) {
						console.log("The error code is: " + xhr.statusText);
					}
				});
			}
		});
	});

	$("#sign_out").click(function() {
		FB.getLoginStatus(function(response) {
			if (response.authResponse) {
				// the user is logged in and has authenticated the app
				FB.logout();
			}
		});

	});

	//allow app to break out of facebook canvas
	$(function() {
		if (top.location != self.location) {
			top.location = self.location;
		}
	});

});

