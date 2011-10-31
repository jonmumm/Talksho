Talkshow.Collections.StageCollection = Backbone.Collection.extend
  initialize: ->
    $(document).bind 'joinEvent', $.proxy @onJoinEvent, @

    # Handle all new streams
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
      stateItem = app.get('stateItems').get(stream.streamId)
      if stateItem?
        state = stateItem.get 'state'
      else
        state = "queue"

      @add new Talkshow.Models.StageItem
        id: stream.streamId
        stream: stream
        state: state
