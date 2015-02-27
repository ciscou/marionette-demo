app = @app

app.views.activeJourneys ?= {}

app.views.activeJourneys.ListItem = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['active_journeys/list_item']
  tagName: 'li'
  className: 'list-group-item'
  events:
    'click': 'onClick'
  modelEvents:
    'highlight': 'highlight'
  onClick: (e) ->
    e.preventDefault()
    @highlight()
  highlight: ->
    view = new app.views.activeJourneys.Details(model: @model)
    @$el.closest('.panel-group').find('.list-group-item').removeClass('active')
    @$el.addClass('active')
    app.main.show(view)
  serializeData: ->
    attrs = @model.toJSON()
    attrs.start_at_day = ("0" + new Date(attrs.start_at).getDate()).slice(-2)
    attrs.start_at_month = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"][new Date(@model.get('start_at')).getMonth()]
    attrs
