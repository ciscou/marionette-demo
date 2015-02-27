app = @app

app.routers.Account = Backbone.Router.extend
  routes:
    'account': 'account'
  account: ->
    $('#sidebar').empty()
    $('#tabs a.journeys').removeClass('active')
    $('#tabs a.account').addClass('active')

new app.routers.Account()
