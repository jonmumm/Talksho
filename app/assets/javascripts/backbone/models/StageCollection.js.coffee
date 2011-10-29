Talkshow.Collections.StageCollection = Backbone.Collection.extend
  initialize: ->
    $(document).bind 'joinEvent', $.proxy @onJoinEvent, @
    session.addEventListener 'streamConnected', $.proxy @onStreamCreated, @
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnected, @

  model: Talkshow.Models.StageItem

  onJoinEvent: ->
    @add new Talkshow.Models.StageItem
      id: "myPublisher"
      state: "publish"

  onSessionConnected: (event) ->
    for stream in event.streams
      @addStreamToCollection stream
  
  onStreamCreated:(event) ->
    for stream in event.streams
      @addStreamToCollection stream

  updateStreamCollection: (stream) ->
    if stream.connection.connectionId isnt session.connection.connectionId
      @add new Talkshow.Models.StageItem
        id: streamId
        stream: stream
        state: "queue"
    else
      # If user is moderator
      if session.capabilities.forceDisconnect
        @get("myPublisher").set
          state: "host"
      else
        @get("myPublisher").set
          state: "queue"
