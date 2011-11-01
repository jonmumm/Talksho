Talkshow.Models.App = Backbone.Model.extend
  initialize: ->
    stageItems = new Talkshow.Collections.StageCollection
    stateItems = new Talkshow.Collections.StateCollection

    # if moderator and not playback
    # state pusher

    @set { stageItems: stageItems, stateItems: stateItems }
