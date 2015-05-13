app = @app

app.routers.Authentication = Backbone.Marionette.AppRouter.extend
  routes:
    '': 'redirectToLoginOrRegister'

  appRoutes:
    'login-or-register': 'loginOrRegister'
    'login':             'login'
    'register':          'register'

  redirectToLogin: ->
    @options.controller.login()
    @navigate('login')

  redirectToLoginOrRegister: ->
    @options.controller.loginOrRegister()
    @navigate('login-or-register')

router = new app.routers.Authentication(controller: app.controllers.Authentication)

app.vent.on "user:registered", -> router.redirectToLogin()
