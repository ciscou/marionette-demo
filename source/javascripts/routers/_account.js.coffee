app = @app

app.routers.Account = Backbone.Router.extend
  routes:
    'account': 'account'
  account: ->
    app.sidebar.show(new app.views.sidebar.AccountTabs())
    $('#main').html('here be an account form')
    $('#tabs a.journeys').removeClass('active')
    $('#tabs a.account').addClass('active')

new app.routers.Account()
