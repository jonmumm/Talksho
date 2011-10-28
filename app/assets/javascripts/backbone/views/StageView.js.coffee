Talkshow.Views.StageView = Backbone.View.extend
  initialize: ->
    $(document).bind 'joinEvent', $.proxy @onJoinEvent, @
    session.addEventListener 'streamCreated', $.proxy @onStreamCreated, @
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnected, @

  onJoinEvent: ->
    streamView = new Talkshow.Views.StreamView
      parent: @el

  onSessionConnected: (event) ->
    for stream in event.streams
      @subscribeToStream stream

  onStreamCreated: (event) ->
    for stream in event.streams
      @subscribeToStream stream
        
  subscribeToStream: (stream) ->
    if stream.connection.connectionId isnt session.connection.connectionId
      streamView = new Talkshow.Views.StreamView
        parent: @el
        stream: stream
