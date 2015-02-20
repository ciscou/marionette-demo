app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.Empty = Backbone.View.extend
  template: HandlebarsTemplates['past_journeys/empty']
  className: 'panel-body'
  render: ->
    @$el.html @template()
    @
