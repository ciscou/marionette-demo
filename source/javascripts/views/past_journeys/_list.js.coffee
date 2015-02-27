app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.List = Backbone.Marionette.CollectionView.extend
  tagName: 'ul'
  className: 'list-group'
  childView: app.views.pastJourneys.ListItem
  emptyView: app.views.pastJourneys.Empty
