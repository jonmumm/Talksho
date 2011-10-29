Talkshow.Views.StageItemView = Backbone.View.extend
  initialize: (attrs) ->
    @model.bind "change:state", $.proxy @onStateChange, @
    @render()

  template: JST["backbone/templates/stageitem"]

  render: ->
    @el.html @template @model.toJSON()
    
    if @model.get('stream')?
      session.subscribe @model.get('stream'), 'videoContainer'
    else
      session.publish 'videoContainer'

  onStateChange: (model, state) ->
    @el.removeClass()
    @el.addClass state
