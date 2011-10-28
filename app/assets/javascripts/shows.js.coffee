# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.session = TB.initSession sessionId

$(document).ready ->
  # Initialize the main stage view
  main = new Talkshow.Views.MainView
    el: $(".main")

  session.connect apiKey, token

