app = @app

app.views.sidebar ?= {}

app.views.sidebar.Tabs = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['sidebar/tabs']

  ui:
    journeys: 'a.journeys'
    account:  'a.account'

  onRender: ->
    @ui[@options.active].addClass('active')
