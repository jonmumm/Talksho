Talkshow.Collections.StateCollection = Backbone.Collection.extend
  initialize: ->
    $.getJSON '/stage', { sessionId: sessionId }, $.proxy @onStateInit, @
    pusher.subscribe(sessionId).bind 'state', $.proxy @onStateUpdate, @

  model: Talkshow.Models.StateItem

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

     
