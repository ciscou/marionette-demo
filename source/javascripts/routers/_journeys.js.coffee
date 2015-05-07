app = @app

app.routers.Journeys = Backbone.Marionette.AppRouter.extend
  routes:
    '': 'redirectToJourneys'
  appRoutes:
    'journeys': 'journeys'
  redirectToJourneys: ->
    app.controllers.Journeys.journeys()
    @navigate('journeys')

router = new app.routers.Journeys(controller: app.controllers.Journeys)

app.vent.on 'user:logged:in', -> router.redirectToJourneys()
