$(document).ready(function() {

    if (window.location.hash && window.location.hash == '#_=_') {
        if (window.history && history.pushState) {
            window.history.pushState("", document.title, window.location.pathname);
        } else {
            // Prevent scrolling by storing the page's current scroll offset
            var scroll = {
                top: document.body.scrollTop,
                left: document.body.scrollLeft
            };
            window.location.hash = '';
            // Restore the scroll offset, should be flicker free
            document.body.scrollTop = scroll.top;
            document.body.scrollLeft = scroll.left;
        }
    }
    
	window.fbAsyncInit = function() {
		FB.init({
			appId : '1375015546079605', // App ID
			status : false, // check login status
			cookie : true, // enable cookies to allow the server to access the session
			xfbml : true, // parse XFBML
			channelUrl   : 'https://desolate-everglades-8674.herokuapp.com/home/fbchannel'
			oauth: true
		});

	};
	
	
  (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
  }(document));


	$("#invite").click(function() {
		alert("jere");
	
		FB.ui({
			method : 'apprequests',
			message : 'I am already using Trippy. Please join me.'
		}, function(response) {
			alert("finished");
			
			var request = response.request;
			var from = $("#user_data").attr("data_user-id");
			$.ajaxSetup({
				headers : {	'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')}
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
						friend_id : to,
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
				FB.logout();
			}
		});

	});
	
	
		$(function() {
		if (top.location != self.location) {
			console.log("change top location");
			console.log(self.location);
			console.log(top.location);
			top.location = self.location;
		}
	});

});

