app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.Details = Backbone.View.extend
  template: HandlebarsTemplates['past_journeys/details']
  events:
    'click .destroy': 'onDestroyClicked'
  onDestroyClicked: (e) ->
    e.preventDefault()
    @model.destroy()
  render: ->
    @$el.html @template @model.toJSON()
    @
