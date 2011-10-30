# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.session = TB.initSession sessionId
window.pusher = new Pusher pusher_key

window.app = new Talkshow.Models.App

$(document).ready ->

  appView = new Talkshow.Views.AppView
    model: app
    el: $(".app")

  session.connect opentok_api_key, opentok_token
