app = @app

app.views.activeJourneys ?= {}

app.views.activeJourneys.List = Backbone.View.extend
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
    view = new app.views.journeysView.Empty()
    @$el.html(view.render().el)
  destroyEmptyView: ->
    if @isShowingEmpty
      @isShowingEmpty = false
      @$el.empty()
  addOne: (journey) ->
    @destroyEmptyView()
    view = new app.views.activeJourneys.ListItem(model: journey)
    @$el.append(view.render().el)
  render: ->
    @$el.empty()
    if @collection.any()
      @collection.each @addOne, this
    else
      @showEmpty()
    @
