extend 'nv.Router', class Router extends Backbone.Router
  routes:
    "*path" : "home"
    
  home: ->
    window.childView = new nv.FirstChildView
    $('#main').append(window.childView.render().el)
