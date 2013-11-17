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

	alert("loadfacebook jdk");
	if (top.location != self.location) {
		alert("here");
		console.log(self.location);
		console.log(top.location);
		top.location = self.location;
	}

	$("#invite").click(function() {
		alert("here");
		FB.ui({
			method : 'apprequests',
			message : 'Try this app',
		}, console.log("response"));
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
/*

 $.ajax
 url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
 dataType: 'script'
 cache: true
 */

