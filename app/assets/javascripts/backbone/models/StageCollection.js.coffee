Talkshow.Collections.StageCollection = Backbone.Collection.extend
  initialize: ->
    $(document).bind 'startShow', $.proxy @onStartShow, @
    $(document).bind 'stopShow', $.proxy @onStopShow, @
    $(document).bind 'joinShow', $.proxy @onJoinShow, @

    # Handle all new streams
    session.addEventListener 'streamCreated', $.proxy @onStreamCreated, @
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnected, @

  model: Talkshow.Models.StageItem

  onStartShow: ->
    if archiveShow
      session.addEventListener 'archiveCreated', (event) =>
        window.archive = event.archives[0]
        session.addEventListener 'sessionRecordingStarted', (event) =>
          @add new Talkshow.Models.StageItem
          $(document).trigger 'startShowComplete'
        session.startRecording(archive)
      session.createArchive opentok_api_key, 'perSession'
    else
      @add new Talkshow.Models.StageItem
      $(document).trigger 'startShowComplete'

  onStopShow: ->
    if archiveShow
      session.addEventListener 'sessionRecordingStopped', (event) =>
        session.addEventListener 'archiveClosed', (event) =>
          # Post archive ID to show
          $.ajax
            type: "post"
            url: "/shows/#{showId}"
            data:
              archiveId: archive.archiveId
          $(document).trigger 'stopShowComplete'
          session.disconnect()
        session.closeArchive archive
      session.stopRecording()
    else
      $(document).trigger 'stopShowComplete'

  onJoinEvent: ->
    @add new Talkshow.Models.StageItem

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
