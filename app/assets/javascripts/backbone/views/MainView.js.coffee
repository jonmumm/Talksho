Talkshow.Views.MainView = Backbone.View.extend
  initialize: ->
    @render()
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnect, @

  template: JST["backbone/templates/main"]

  render: ->
    @el.html @template

    stageView = new Talkshow.Views.StageView
      collection: @model.get 'stageCollection'
      el: $(".stage", @el)

  events:
    "click .joinBtn": "onJoinBtnClick"

  onSessionConnect: ->
    $(".joinBtn", @el).removeAttr "disabled"

  onJoinBtnClick: ->
    $(document).trigger 'joinEvent'
