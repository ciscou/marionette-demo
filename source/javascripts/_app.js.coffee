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
      end_loc: $('input[name="end_loc"]').val()
      vehicle_type: $('select[name="vehicle_type"]').val()
      start_at: new Date()

app.views.ActiveJourneyView = Backbone.View.extend
  template: HandlebarsTemplates['active_journeys/list_item']
  tagName: 'li'
  className: 'list-group-item'
  render: ->
    @$el.html @template @model.attributes
    @

app.views.EmptyActiveJourneysView = Backbone.View.extend
  template: HandlebarsTemplates['active_journeys/empty']
  className: 'panel-body'
  render: ->
    @$el.html @template()
    @

app.views.ActiveJourneysView = Backbone.View.extend
  tagName: 'ul'
  className: 'list-group'
  initialize: ->
    @listenTo @collection, 'all', @render
  addOne: (journey) ->
    view = new app.views.ActiveJourneyView(model: journey)
    @$el.append(view.render().el)
  render: ->
    @$el.empty()
    if @collection.any()
      @collection.each @addOne, this
    else
      view = new app.views.EmptyActiveJourneysView()
      @$el.append(view.render().el)
    @

app.journeys = new app.collections.Journeys()
app.journeys.fetch()

new app.views.OrderJourneyView()
activeJourneysView = new app.views.ActiveJourneysView(collection: app.journeys)
$('#active').html(activeJourneysView.render().el)

@app = app
