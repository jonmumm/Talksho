Talkshow.Views.StageView = Backbone.View.extend
  initialize: ->
    @collection.bind 'add', $.proxy @onStageItemAdd, @
    @collection.bind 'remove', $.proxy @onStageItemRemove, @
    # Post API events out of here

  onStageItemAdd: (model) ->
    viewEl = $(@make "div", { id: model.get('id'), class: model.get('state') } )
    viewEl.appendTo @el

    stageItemView = new Talkshow.Views.StageItemView
      el: viewEl
      model: model

  onStageItemRemove: (model) ->
    $("##{model.get('id')}").remove()
