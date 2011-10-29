# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.session = TB.initSession sessionId
window.state = {}
###
# $.ajax 'getJSON'
###

$(document).ready ->
  main = new Talkshow.Models.Main

  mainView = new Talkshow.Views.MainView
    model: main
    el: $(".main")

  session.connect apiKey, token

