app = @app

app.routers.Account = Backbone.Router.extend
  routes:
    'account': 'account'
  account: ->
    app.sidebar.show(new app.views.sidebar.AccountTabs())

    app.tabs.show(new app.views.sidebar.Tabs(active: 'account'))

    $('#main').html('here be an account form')

new app.routers.Account()
