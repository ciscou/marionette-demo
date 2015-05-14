app = @app

app.routers.Account = Backbone.Router.extend
  routes:
    'account': 'account'
  account: ->
    sidebar = new app.views.sidebar.Layout(active: 'account')
    app.sidebar.show(sidebar)

    sidebar.content.show(new app.views.sidebar.AccountTabs())

    $('#main').html('here be an account form')

new app.routers.Account()
