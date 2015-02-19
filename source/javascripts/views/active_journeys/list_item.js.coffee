app = @app

app.views.activeJourneys ?= {}

app.views.activeJourneys.ListItem = Backbone.View.extend
  template: HandlebarsTemplates['active_journeys/list_item']
  tagName: 'li'
  className: 'list-group-item'
  events:
    'click .finish': 'onFinishClicked'
  initialize: ->
    @listenTo @model, 'remove', @remove
  onFinishClicked: (e) ->
    e.preventDefault()
    @model.finish()
    $('a.collapse-past').click()
  render: ->
    @$el.html @template @model.attributes
    @
