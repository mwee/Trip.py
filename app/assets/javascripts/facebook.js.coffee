# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


fb_root = null
fb_events_bound = false

$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless fb_events_bound

bindFacebookEvents = ->
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', ->
      FB?.XFBML.parse()
    )
  fb_events_bound = true

saveFacebookRoot = ->
  fb_root = $('#fb-root').detach()

restoreFacebookRoot = ->
  if $('#fb-root').length > 0
    $('#fb-root').replaceWith fb_root
  else
    $('body').append fb_root

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/en_US/all.js")

initializeFacebookSDK = ->
  FB.init
    appId     : '1375015546079605'
    channelUrl: 'https://infinite-beyond-7744.herokuapp.com/home/fbchannel'
    status    : true
    cookie    : true
    xfbml     : true
    