app = @app

app.views.journeysView ?= {}

app.views.journeysView.Empty = Backbone.View.extend
  template: HandlebarsTemplates['active_journeys/empty']
  className: 'panel-body'
  render: ->
    @$el.html @template()
    @
