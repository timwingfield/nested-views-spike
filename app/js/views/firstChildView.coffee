extend 'nv.FirstChildView', class FirstChildView extends Backbone.Fixins.SuperView
  template: "app/templates/first-child.us"
  
  initialize: ->
    @model1 = new Backbone.Model id: 5, name: "andy"
    @model2 = new Backbone.Model id: 9, name: "justin"
    @collection = new Backbone.Collection [@model1, @model2]
    nv.vent.on("gc:clicked", @kidAlert)

  
  makeAKidAndThenRender: (model) =>
    gcv = new nv.GrandChildView(model: model)
    $('<li></li>').appendTo(@$(".childs")).append(gcv.render().el)

  renderKids: ->
    @collection.each (model) => @makeAKidAndThenRender(model)

  kidAlert: (kid) =>
    alert("vent worked #{kid.model.get('id')}")

extend 'nv.GrandChildView', class GrandChildView extends Backbone.Fixins.SuperView
  template: "app/templates/grand-child.us"

  initialize: ->
    @$el.on('click', @displayId)

  displayId: =>
    nv.vent.trigger("gc:clicked", @)
