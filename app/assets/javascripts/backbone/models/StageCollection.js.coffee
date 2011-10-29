Talkshow.Collections.StageCollection = Backbone.Collection.extend
  initialize: ->
    $(document).bind 'joinEvent', $.proxy @onJoinEvent, @
    session.addEventListener 'streamCreated', $.proxy @onStreamCreated, @
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnected, @

  model: Talkshow.Models.StageItem

  onJoinEvent: ->
    @add new Talkshow.Models.StageItem
      id: "myPublisher"
      state: "publish"

  onSessionConnected: (event) ->
    for stream in event.streams
      @updateStreamCollection stream
  
  onStreamCreated:(event) ->
    for stream in event.streams
      @updateStreamCollection stream

  updateStreamCollection: (stream) ->
    if stream.connection.connectionId isnt session.connection.connectionId
      console.log stream

      switch stream.streamId
        when state.guest then itemState = "guest"
        when state.host then itemState = "host"
        else itemState = "queue"

      @add new Talkshow.Models.StageItem
        id: stream.streamId
        stream: stream
        state: itemState
