app = @app

app.views.sidebar ?= {}

app.views.sidebar.Accordion = Backbone.Marionette.ItemView.extend
  id: 'accordion'
  className: 'panel-group'
  template: HandlebarsTemplates['sidebar/accordion']
