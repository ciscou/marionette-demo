app = @app

app.views.activeJourneys ?= {}

app.views.activeJourneys.List = Backbone.Marionette.CollectionView.extend
  tagName: 'ul'
  className: 'list-group'
  childView: app.views.activeJourneys.ListItem
  emptyView: app.views.activeJourneys.Empty
