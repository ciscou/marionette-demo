app =
  models: {}
  collections: {}
  views: {}
  controllers: {}
  routers: {}

app.models.Journey = Backbone.Model.extend
  defaults:
    start_loc: ''
    end_loc: ''
    vehicle_type: ''
    start_at: null
    end_at: null

app.collections.Journeys = Backbone.Collection.extend
  localStorage: new Backbone.LocalStorage("journeys")
  model: app.models.Journey

app.views.OrderJourneyView = Backbone.View.extend
  el: $('#order-journey-form')
  events:
    submit: 'onSubmit'
  onSubmit: (e) ->
    e.preventDefault()
    app.journeys.create
      start_loc: $('input[name="start_loc"]').val()
      end_loc: $('input[name="start_loc"]').val()
      vehicle_type: $('input[name="vehicle_type"]').val()
      start_at: new Date()

app.journeys = new app.collections.Journeys()
app.journeys.fetch()

$ ->
  new app.views.OrderJourneyView()

@app = app
