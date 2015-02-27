app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.Details = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['past_journeys/details']
  events:
    'click .destroy': 'onDestroyClicked'
  onDestroyClicked: (e) ->
    e.preventDefault()
    @$('.destroy').attr('disabled', true)
    @model.destroy()
