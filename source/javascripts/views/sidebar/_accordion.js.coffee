app = @app

app.views.sidebar ?= {}

app.views.sidebar.Accordion = Backbone.View.extend
  id: 'accordion'
  className: 'panel-group'
  template: HandlebarsTemplates['sidebar/accordion']
  render: ->
    @$el.html @template()
    new app.views.journeys.OrderForm(el: @$('#order-journey-form'))
    @
