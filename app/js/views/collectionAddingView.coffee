extend 'nv.AndyMain', class AndyMain extends Backbone.Fixins.SuperView
  template: "app/templates/andy-main.us"

  initialize: ->
    @model1 = new Backbone.Model id: 3, name: "person 1"
    @model2 = new Backbone.Model id: 29, name: "person 2"
    @collection = new Backbone.Collection [@model1, @model2]


  renderList: ->
    @collection.each (model) => @listPersons(model)


  listPersons: (model) =>
    andyList = new nv.AndyList model: model
    @$('.andy-main').append(andyList.render().el)

    @displayCollectionAddingView(model)


  displayCollectionAddingView: =>
    cav =  new CollectionAddingView
    @$('.andy-main').append(cav.render().el)

extend 'nv.AndyList', class AndyList extends Backbone.Fixins.SuperView
  template: "app/templates/andy-list.us"


extend 'nv.CollectionAddingView', class CollectionAddingView extends Backbone.Fixins.SuperView
  template: "app/templates/collection-adding.us"

  events:
    "click .add" : "addPerson"

  initialize: ->
    nv.vent.on("person:removed", @removePerson)
    @_personListViews = []
    @collection = new Backbone.Collection
    @collection.on 'add', @addPersonToList
    @collection.on 'remove', @removePersonFromList

  addPerson: ->
    person = @$('.person').val()
    @collection.add(new Backbone.Model person: person)
  
  addPersonToList: (model) =>
    v = new nv.PersonListItemView(model: model)
    @_personListViews[model.cid] = v
    @$('.list-container').append(v.render().el)

  removePerson: (personListItem) =>
    @collection.remove(personListItem.model)

  removePersonFromList: (model) =>
    @_personListViews[model.cid].remove()


extend 'nv.PersonListItemView', class PersonListItemView extends Backbone.Fixins.SuperView
  template: "app/templates/person-list-item.us"
  className: 'person-list-item'
  initialize: ->
    @model.set "cid", @model.cid

  events:
    "click .remove-me" : "removeMe"

  removeMe: ->
    nv.vent.trigger("person:removed", @)
