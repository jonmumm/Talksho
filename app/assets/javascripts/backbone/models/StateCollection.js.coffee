Talkshow.Collections.StateCollection = Backbone.Collection.extend
  initialize: ->
    $.getJSON "/states/#{sessionId}", $.proxy @onStateInit, @
    pusher.subscribe(sessionId).bind 'state', $.proxy @onStateUpdate, @

    #if moderator
      #session.addEventListener 'streamCreated', @onSteamCreated

  model: Talkshow.Models.StateItem

  onStreamCreated: (event) ->
    for stream in event.streams
      do (stream) =>
        if stream.connection.connectionId is session.connection.connectionId
          state = 'host'
        else
          state = 'queue'
        $.ajax
          type: "post"
          url: "/states/#{sessionId}"
          data:
            state: state
            streamId: stream.streamId

  onStateInit: (state) ->
    for item in state
      @addOrUpdateState item

  onStateUpdate: (item) ->
    @addOrUpdateState item

  addOrUpdateState: (item) ->
    if @get(item.streamId)?
      @get(item.streamId).set { state: item.state }
    else
      @add new Talkshow.Models.StateItem
        id: item.streamId
        state: item.state

     
