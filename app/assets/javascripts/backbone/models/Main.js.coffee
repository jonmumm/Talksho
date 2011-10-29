Talkshow.Models.Main = Backbone.Model.extend
  initialize: ->
    @set
      stageCollection: new Talkshow.Collections.StageCollection
