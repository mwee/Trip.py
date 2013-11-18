$(document).ready(function() {

	window.fbAsyncInit = function() {
		FB.init({
			appId : '251622244993391', // App ID
			status : true, // check login status
			cookie : true, // enable cookies to allow the server to access the session
			xfbml : true // parse XFBML
		});

	};
	( function(d) {
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

	/*
	 * 		FB.ui({
	 method : 'send',

	 link : 'http://stark-dawn-4251.herokuapp.com/',
	 }, console.log("response"));
	 */
	/*
	 * link : 'http://stark-dawn-4251.herokuapp.com/',
	 */

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
			for (var i = 0; i < response.to.length; i++) {
				var to = response.to[i];
				console.log(request + " " + from + " " + to);
				$.post("/invites/create", {
					request_id : request,
					from : from,
					to : to,

				}, function(response) {
					console.log(response["to"]);
				});

				/*
				 $.ajax({
				 type : "POST",
				 url : "/invites/create",
				 data : {
				 invite : {
				 request_id : request,
				 from : from,
				 to : to,
				 }
				 },
				 statusCode : {
				 422 : function(jqXHR, textStatus, errorThrown) {
				 var json = $.parseJSON(jqXHR.responseText)
				 console.log(json);
				 }
				 },

				 success : function() {
				 alert("Data Send!");
				 },
				 error : function(xhr) {
				 xhr.alert("The error code is: " + xhr.statusText);
				 }
				 });
				 */
			}
		});
	});

	$("#sign_in").click(function() {
		//e.preventDefault();
		/*
		 alert("here");
		 FB.login(function(response) {
		 if (response.authResponse) {
		 // The person logged into your app
		 window.location = '/auth/facebook/callback';
		 }
		 });
		 */
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
			} else {
				// the user isn't logged in to Facebook.
			}
		});

	});
	/*
	 $('#sign_out').click (e) ->
	 FB.getLoginStatus (response) ->
	 FB.logout() if response.authResponse
	 true

	 */
});

