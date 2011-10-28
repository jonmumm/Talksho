Talkshow.Views.StreamView = Backbone.View.extend
  initialize: (attrs) ->
    @parent = attrs.parent
    @stream = attrs.stream if attrs.stream?
    @render()

  template: JST["backbone/templates/stream"]

  render: ->
    @el = $(@make "div", class: 'video')
    @el.html @template
    @el.appendTo @parent
    if @stream?
      # Should have state by now
      # Set class accordingly
      @el.addClass 'queue'
      session.subscribe @stream, 'videoContainer'
    else
      @el.addClass 'host'
      session.publish 'videoContainer'

