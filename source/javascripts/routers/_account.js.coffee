app = @app

app.routers.Account = Backbone.Router.extend
  routes:
    'account': 'account'
  account: ->
    $('#accordion').hide()
    $('#tabs a.journeys').removeClass('active')
    $('#tabs a.account').addClass('active')

new app.routers.Account()
