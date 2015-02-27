app = @app

app.controllers.Journeys =
  journeys: ->
    $('#sidebar').html(new app.views.sidebar.Accordion().render().el)
    $('#main').html('here be a map')
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
