app = @app

app.routers.Authentication = Backbone.Marionette.AppRouter.extend
  appRoutes:
    'login': 'login'

new app.routers.Authentication(controller: app.controllers.Authentication)
