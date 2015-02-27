app = @app

app.views.sidebar ?= {}

app.views.sidebar.Accordion = Backbone.Marionette.LayoutView.extend
  id: 'accordion'
  className: 'panel-group'
  template: HandlebarsTemplates['sidebar/accordion']
  regions:
    order: '#order'
    active: '#active'
    past: '#past'
