$(document).ready(function() {

	window.fbAsyncInit = function() {
		FB.init({
			appId : '251622244993391', // App ID
			status : true, // check login status
			cookie : true, // enable cookies to allow the server to access the session
			xfbml : true // parse XFBML
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

	$(function() {
		if (top.location != self.location) {
			console.log("change top location");
			console.log(self.location);
			console.log(top.location);
			top.location = self.location;
		}
	});

	$("#invite").click(function() {

		FB.ui({
			method : 'apprequests',
			message : 'try this app',
		}, function(response) {
			var request = response.request;
			var from = $("#user_data").attr("data_user-id");
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
						request_id : request,
						user_id : from,
						friend_id : to,
						status:"pending",

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
				// the user is logged in and has authenticated your
				// app, and response.authResponse supplies
				// the user's ID, a valid access token, a signed
				// request, and the time the access token
				// and signed request each expire
				//var uid = response.authResponse.userID;
				//var accessToken = response.authResponse.accessToken;
				FB.logout()
			}
		});

	});

});

