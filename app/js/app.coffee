extend 'nv.App', class App
  constructor: ->
    @router = new nv.Router

  start: ->
    Backbone.history.start()

$ -> nv.app = new nv.App(); nv.app.start()
