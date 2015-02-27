app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.List = Backbone.Marionette.CollectionView.extend
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
    view = new app.views.pastJourneys.Empty()
    @$el.html(view.render().el)
  destroyEmptyView: ->
    if @isShowingEmpty
      @isShowingEmpty = false
      @$el.empty()
  addOne: (journey) ->
    @destroyEmptyView()
    view = new app.views.pastJourneys.ListItem(model: journey)
    @$el.append(view.render().el)
  render: ->
    @$el.empty()
    if @collection.any()
      @collection.each @addOne, this
    else
      @showEmpty()
    @
