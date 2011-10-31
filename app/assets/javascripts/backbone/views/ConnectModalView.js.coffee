Talkshow.Views.ConnectModalView = Backbone.View.extend
  initialize: ->
    session.addEventListener 'sessionConnected', $.proxy @onSessionConnect, @
    @render()

  template: JST["backbone/templates/connectmodal"]

  render: ->
    @el = $(@make "div", { id: "connectModal", class: "modal hide fade" })
    @el.html @template
    @el.appendTo 'body'
    @el.modal
      backdrop: true
      show: true

  onSessionConnect: ->
    @el.modal 'hide'

