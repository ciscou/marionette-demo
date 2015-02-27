app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.Empty = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['past_journeys/empty']
  className: 'panel-body'
