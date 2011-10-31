Talkshow.Models.StateItem = Backbone.Model.extend
  initialize: ->
    @updateStageItem()
    @bind "change:state", @onStateChange
    console.log 'stateItem init'

  onStateChange: ->
    @updateStageItem()

  updateStageItem: ->
    stageItem = app.get('stageItems').get(@id)
    stageItem.set( { state: @get('state') } ) unless not stageItem?
