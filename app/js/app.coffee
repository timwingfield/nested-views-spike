extend 'nv.App', class App
  constructor: ->
    @router = new nv.Router
    nv.vent = new Marionette.EventAggregator

  start: ->
    Backbone.history.start()

$ -> nv.app = new nv.App(); nv.app.start()
