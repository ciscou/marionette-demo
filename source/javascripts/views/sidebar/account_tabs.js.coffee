app = @app

app.views.sidebar ?= {}

app.views.sidebar.AccountTabs = Backbone.View.extend
  template: HandlebarsTemplates['sidebar/account_tabs']
  render: ->
    @$el.html @template()
    @
