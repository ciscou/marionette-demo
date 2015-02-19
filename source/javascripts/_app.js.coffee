app =
  models: {}
  collections: {}
  views: {}
  controllers: {}
  routers: {}

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

@app = app
