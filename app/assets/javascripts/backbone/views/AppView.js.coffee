Talkshow.Views.AppView = Backbone.View.extend
  initialize: ->
    @render()
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnect, @

  template: JST["backbone/templates/app"]

  render: ->
    @el.html @template

    stageView = new Talkshow.Views.StageView
      collection: @model.get 'stageItems'
      el: $(".stage", @el)

  events:
    "click .joinBtn": "onJoinBtnClick"

  onSessionConnect: ->
    $(".joinBtn", @el).removeAttr "disabled"

  onJoinBtnClick: ->
    $(document).trigger 'joinEvent'
