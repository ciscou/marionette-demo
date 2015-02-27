app = @app

app.routers.Journeys = Backbone.Marionette.AppRouter.extend
  routes:
    '': 'redirectToJourneys'
  appRoutes:
    'journeys': 'journeys'
  redirectToJourneys: ->
    app.controllers.Journeys.journeys()
    @navigate('journeys')

new app.routers.Journeys(controller: app.controllers.Journeys)
