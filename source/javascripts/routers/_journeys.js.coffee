app = @app

app.routers.Journeys = Backbone.Router.extend
  routes:
    '': 'redirectToJourneys'
    'journeys': 'journeys'
  redirectToJourneys: ->
    @journeys()
    @navigate('journeys')
  journeys: ->
    $('#sidebar').html(new app.views.sidebar.Accordion().render().el)
    $('#tabs a.journeys').addClass('active')
    $('#tabs a.account').removeClass('active')

    app.journeys = new app.collections.Journeys()
    app.journeys.fetch()

    app.activeJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isActive()

    app.pastJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isPast()

    activeJourneysView = new app.views.activeJourneys.List(collection: app.activeJourneys)
    $('#active').html(activeJourneysView.render().el)

    pastJourneysView = new app.views.pastJourneys.List(collection: app.pastJourneys)
    $('#past').html(pastJourneysView.render().el)

new app.routers.Journeys()
