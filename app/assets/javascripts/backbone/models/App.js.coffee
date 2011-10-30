Talkshow.Models.App = Backbone.Model.extend
  initialize: ->
    stageItems = new Talkshow.Collections.StageCollection
    stateItems = new Talkshow.Collections.StateCollection

    @set { stageItems: stageItems, stateItems: stateItems }
