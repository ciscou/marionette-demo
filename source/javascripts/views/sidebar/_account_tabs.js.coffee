app = @app

app.views.sidebar ?= {}

app.views.sidebar.AccountTabs = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['sidebar/account_tabs']
