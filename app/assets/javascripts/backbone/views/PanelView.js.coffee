Talkshow.Views.PanelView = Backbone.View.extend
  initialize: ->
    $(document).bind 'startShowComplete', $.proxy @onStartShowComplete, @
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnect, @

    @render()

  template: JST["backbone/templates/panel"]

  render: ->
    @el.html @template

  events:
    "click .startShowBtn": "onStartShowClick"
    "click .stopShowBtn": "onStopShowClick"
    "click .joinShowBtn": "onJoinShowClick"
    "click .leaveShowBtn": "onLeaveShowClick"
    "click .startPlaybackBtn": "onStartPlaybackClick"
    "click .stopPlaybackBtn": "onStopPlaybackClick"

  onSessionConnect: ->
    $(".startShowBtn", @el).removeAttr "disabled"
    $(".joinShowBtn", @el).removeAttr "disabled"

  onStartShowClick: ->
    $(document).trigger 'startShow'
    $(@).attr 'disabled', 'disabled'

  onStopShowClick: ->
    $(document).trigger 'stopShow'
    $(@).attr 'disabled', 'disabled'

  onJoinShowClick: ->
    $(document).trigger 'joinShow'
    $(@).attr 'disabled', 'disabled'

  onLeaveShowClick: ->
    $(document).trigger 'leaveShow'
    $(@).attr 'disabled', 'disabled'

  onStartPlaybackClick: ->
    $(document).trigger 'startPlayback'
    $(@).attr 'disabled', 'disabled'

  onStopPlaybackClick: ->
    $(document).trigger 'stopPlayback'
    $(@).attr 'disabled', 'disabled'

  onStartShowComplete: ->
    $(".stopShowBtn").attr 'disabled', ''
