app = @app

app.views.activeJourneys ?= {}

app.views.activeJourneys.Empty = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['active_journeys/empty']
  className: 'panel-body'
