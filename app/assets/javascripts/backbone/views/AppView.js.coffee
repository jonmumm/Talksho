Talkshow.Views.AppView = Backbone.View.extend
  initialize: ->
    @render()

  template: JST["backbone/templates/app"]

  render: ->
    @el.html @template

    connectView = new Talkshow.Views.ConnectModalView
    panelView = new Talkshow.Views.PanelView
      el: $(".panel", @el)
    stageView = new Talkshow.Views.StageView
      collection: @model.get 'stageItems'
      el: $(".stage", @el)

