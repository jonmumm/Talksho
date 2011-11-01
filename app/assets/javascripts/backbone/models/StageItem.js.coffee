Talkshow.Models.StageItem = Backbone.Model.extend
  initialize: ->
    session.addEventListener 'streamCreated', $.proxy @onStreamCreated, @
  
  defaults:
    id: "myPublisher"
    state: "publish"

  onStreamCreated: (event) ->
    for stream in event.streams
      do (stream) =>
        if @id is "myPublisher" and stream.connection.connectionId is session.connection.connectionId
          @set
            stream: stream
            id: stream.streamId
          #NOTE this might be racing against pusher, look up streamId in statecollection if this isnt working
  
