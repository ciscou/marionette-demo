app = @app

app.controllers.Journeys =
  order: ->
    @journeys('order')

  active: ->
    @journeys('active')

  past: ->
    @journeys('past')

  journeys: (current) ->
    sidebar = new app.views.sidebar.Layout(active: 'journeys')
    app.sidebar.show(sidebar)

    accordion = new app.views.sidebar.Accordion(current: current)
    sidebar.content.show(accordion)

    $('#main').html('here be a map')

    app.journeys = new app.collections.Journeys()
    app.journeys.fetch()

    app.activeJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isActive()

    app.pastJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isPast()

    activeJourneysView = new app.views.activeJourneys.List(collection: app.activeJourneys)
    accordion.active.show(activeJourneysView)

    pastJourneysView = new app.views.pastJourneys.List(collection: app.pastJourneys)
    accordion.past.show(pastJourneysView)

    orderFormView = new app.views.journeys.OrderForm()
    orderFormView.on 'submit', ->
      journey = new app.models.Journey orderFormView.getData(), collection: app.journeys
      if journey.save()
        orderFormView.reset()
        app.journeys.add(journey)
        $('#active').collapse('show')
        journey.trigger('highlight')
      else
        orderFormView.onFormDataInvalid(journey.validationError)
    accordion.order.show(orderFormView)
