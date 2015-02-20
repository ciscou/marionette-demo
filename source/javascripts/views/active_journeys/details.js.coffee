app = @app

app.views.activeJourneys ?= {}

app.views.activeJourneys.Details = Backbone.View.extend
  template: HandlebarsTemplates['active_journeys/details']
  events:
    'click .finish': 'onFinishClicked'
  onFinishClicked: (e) ->
    e.preventDefault()
    @$('.finish').attr('disabled', true)
    @model.finish()
    $('#past').collapse('show')
    @model.trigger('highlight')
  render: ->
    @$el.html @template @model.toJSON()
    @
