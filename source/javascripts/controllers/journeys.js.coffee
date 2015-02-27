app = @app

app.controllers.Journeys =
  journeys: ->
    accordion = new app.views.sidebar.Accordion()
    app.sidebar.show(accordion)
    $('#main').html('here be a map')
    $('#tabs a.journeys').addClass('active')
    $('#tabs a.account').removeClass('active')

    app.journeys = new app.collections.Journeys()
    app.journeys.fetch()

    app.activeJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isActive()

    app.pastJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isPast()

    activeJourneysView = new app.views.activeJourneys.List(collection: app.activeJourneys)
    accordion.active.show(activeJourneysView)

    pastJourneysView = new app.views.pastJourneys.List(collection: app.pastJourneys)
    accordion.past.show(pastJourneysView)

    orderFormView = new app.views.journeys.OrderForm(el: $('#order-journey-form'))
    orderFormView.on 'submit', ->
      journey = new app.models.Journey orderFormView.getData(), collection: app.journeys
      if journey.save()
        orderFormView.reset()
        app.journeys.add(journey)
        $('#active').collapse('show')
        journey.trigger('highlight')
      else
        orderFormView.onFormDataInvalid(journey.validationError)
