app = @app

app.routers.Journeys = Backbone.Marionette.AppRouter.extend
  routes:
    '': 'redirectToOrderJourney'
  appRoutes:
    'journeys/order':  'order'
    'journeys/active': 'active'
    'journeys/past':   'past'
  redirectToOrderJourney: ->
    app.controllers.Journeys.order()
    @navigate('journeys/order')

router = new app.routers.Journeys(controller: app.controllers.Journeys)

app.vent.on 'user:logged:in', -> router.redirectToOrderJourney()
