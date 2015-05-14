app = @app

app.views.sidebar ?= {}

app.views.sidebar.Layout = Backbone.Marionette.LayoutView.extend
  template: HandlebarsTemplates['sidebar/layout']

  regions:
    tabs:    '#sidebar-tabs'
    content: '#sidebar-content'

  onShow: ->
    @tabs.show(new app.views.sidebar.Tabs(active: @options.active))
