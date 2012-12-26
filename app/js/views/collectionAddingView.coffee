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
