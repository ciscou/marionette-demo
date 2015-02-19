app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.ListItem = Backbone.View.extend
  template: HandlebarsTemplates['past_journeys/list_item']
  tagName: 'li'
  className: 'list-group-item'
  events:
    'click .destroy': 'onDestroyClicked'
  initialize: ->
    @listenTo @model, 'destroy', @remove
  onDestroyClicked: (e) ->
    e.preventDefault()
    @model.destroy()
  render: ->
    @$el.html @template @model.attributes
    @
