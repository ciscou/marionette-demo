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
  finish: ->
    @save('end_at', new Date())
  isActive: ->
    !@isPast()
  isPast: ->
    @has('end_at')
  validate: (attrs, opts) ->
    errors = {}

    unless attrs.start_loc
      errors.start_loc = "can't be blank"
    unless attrs.end_loc
      errors.end_loc = "can't be blank"
    unless attrs.vehicle_type
      errors.vehicle_type = "can't be blank"

    if _.isEmpty(errors)
      undefined
    else
      errors

app.collections.Journeys = Backbone.Collection.extend
  localStorage: new Backbone.LocalStorage("journeys")
  model: app.models.Journey

app.views.OrderJourneyView = Backbone.View.extend
  el: $('#order-journey-form')
  events:
    submit: 'onSubmit'
  onSubmit: (e) ->
    e.preventDefault()
    data =
      start_loc: @$('input[name="start_loc"]').val()
      end_loc: @$('input[name="end_loc"]').val()
      vehicle_type: @$('select[name="vehicle_type"]').val()
      start_at: new Date()
    journey = new app.models.Journey data, collection: app.journeys
    if journey.save()
      @reset()
      app.journeys.add(journey)
      $('a.collapse-active').click()
    else
      @onFormDataInvalid(journey.validationError)
  reset: ->
    @$('.form-group.has-error').removeClass('has-error').find('span.help-block').remove()
    @$('input[name="start_loc"]').val('')
    @$('input[name="end_loc"]').val('')
    @$('select[name="vehicle_type"]').val('')
  onFormDataInvalid: (errors) ->
    @$('.form-group.has-error').removeClass('has-error').find('span.help-block').remove()
    _.each errors, (value, key) ->
      $formGroup = @$("[name=#{key}]").parent()
      $errorEl = $('<span>', class: 'help-block', text: value)
      $formGroup.addClass('has-error').append($errorEl)

app.views.ActiveJourneyView = Backbone.View.extend
  template: HandlebarsTemplates['active_journeys/list_item']
  tagName: 'li'
  className: 'list-group-item'
  events:
    'click .finish': 'onFinishClicked'
  initialize: ->
    @listenTo @model, 'remove', @remove
  onFinishClicked: (e) ->
    e.preventDefault()
    @model.finish()
    $('a.collapse-past').click()
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
    @listenTo @collection, 'reset',  @render
    @listenTo @collection, 'add',    @addOne
    @listenTo @collection, 'remove', @checkEmpty
  checkEmpty: ->
    if @collection.isEmpty()
      @showEmpty()
  showEmpty: ->
    @isShowingEmpty = true
    view = new app.views.EmptyActiveJourneysView()
    @$el.html(view.render().el)
  destroyEmptyView: ->
    if @isShowingEmpty
      @isShowingEmpty = false
      @$el.empty()
  addOne: (journey) ->
    @destroyEmptyView()
    view = new app.views.ActiveJourneyView(model: journey)
    @$el.append(view.render().el)
  render: ->
    @$el.empty()
    if @collection.any()
      @collection.each @addOne, this
    else
      @showEmpty()
    @

app.views.PastJourneyView = Backbone.View.extend
  template: HandlebarsTemplates['past_journeys/list_item']
  tagName: 'li'
  className: 'list-group-item'
  events:
    'click .destroy': 'onDestroyClicked'
  initialize: ->
    @listenTo @model, 'destroy', @remove
  onDestroyClicked: (e) ->
    e.preventDefault()
    @model.destroy()
  render: ->
    @$el.html @template @model.attributes
    @

app.views.EmptyPastJourneysView = Backbone.View.extend
  template: HandlebarsTemplates['past_journeys/empty']
  className: 'panel-body'
  render: ->
    @$el.html @template()
    @

app.views.PastJourneysView = Backbone.View.extend
  tagName: 'ul'
  className: 'list-group'
  initialize: ->
    @listenTo @collection, 'reset',  @render
    @listenTo @collection, 'add',    @addOne
    @listenTo @collection, 'remove', @checkEmpty
  checkEmpty: ->
    if @collection.isEmpty()
      @showEmpty()
  showEmpty: ->
    @isShowingEmpty = true
    view = new app.views.EmptyPastJourneysView()
    @$el.html(view.render().el)
  destroyEmptyView: ->
    if @isShowingEmpty
      @isShowingEmpty = false
      @$el.empty()
  addOne: (journey) ->
    @destroyEmptyView()
    view = new app.views.PastJourneyView(model: journey)
    @$el.append(view.render().el)
  render: ->
    @$el.empty()
    if @collection.any()
      @collection.each @addOne, this
    else
      @showEmpty()
    @

app.journeys = new app.collections.Journeys()
app.journeys.fetch()

app.activeJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isActive()

app.pastJourneys = new Backbone.Obscura(app.journeys).filterBy (model) -> model.isPast()

new app.views.OrderJourneyView()

activeJourneysView = new app.views.ActiveJourneysView(collection: app.activeJourneys)
$('#active').html(activeJourneysView.render().el)

pastJourneysView = new app.views.PastJourneysView(collection: app.pastJourneys)
$('#past').html(pastJourneysView.render().el)

@app = app
