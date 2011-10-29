Talkshow.Models.StageItem = Backbone.Model.extend
  initialize: ->
    session.addEventListener 'streamCreated', $.proxy @onStreamCreated, @
    @bind 'stageEnter', @onStageEnter
    # Listen for pusher here event changes here
    # If streamId == this id, update the status
  
  onStreamCreated: (event) ->
    for stream in event.streams
      do (stream) =>
        if stream.connection.connectionId is session.connection.connectionId
          if session.capabilities.forceDisconnect
            @set
              stream: stream
              id: stream.streamId
            @updateRemoteState 'host'
          else
            @set 'state', 'queue'

  onStageEnter: ->
    @updateRemoteState 'guest'
  
  updateRemoteState: (state) ->
    $.ajax
      type: 'post'
      url: '/stage'
      data:
        sessionId: sessionId
        state: state
        streamId: @get('stream').streamId
      success: (data) ->
        console.log data
