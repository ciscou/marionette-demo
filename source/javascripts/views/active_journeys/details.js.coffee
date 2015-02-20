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
    $('a.collapse-past').click()
  render: ->
    @$el.html @template @model.toJSON()
    @
