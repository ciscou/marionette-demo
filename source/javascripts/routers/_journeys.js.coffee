app = @app

app.routers.Journeys = Backbone.Marionette.AppRouter.extend
  routes:
    '': 'redirectToOrderJourney'

  appRoutes:
    'journeys/order':  'order'
    'journeys/active': 'active'
    'journeys/past':   'past'

  redirectToOrderJourney: ->
    @options.controller.order()
    @navigateToJourneys('order')

  navigateToJourneys: (current) ->
    @navigate("journeys/#{current}")

router = new app.routers.Journeys(controller: app.controllers.Journeys)

app.vent.on 'user:logged:in', -> router.redirectToOrderJourney()
app.vent.on 'navigate:journeys', (current) -> router.navigateToJourneys(current)
