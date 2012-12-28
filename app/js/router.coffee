extend 'nv.Router', class Router extends Backbone.Router
  routes:
    "andy": "andy"
    "people-list" : "peopleList"
    "*path" : "home"
    
  home: ->
    window.childView = new nv.FirstChildView
    $('#main').append(window.childView.render().el)

  peopleList: ->
    if window.childView then window.childView.remove()
    
    window.collectionAddingView = new nv.CollectionAddingView
    $('#main').append(window.collectionAddingView.render().el)

  andy: ->
    if window.childView then window.childView.remove()

    window.andyMain =  new nv.AndyMain
    $('#main').append(window.andyMain.render().el)