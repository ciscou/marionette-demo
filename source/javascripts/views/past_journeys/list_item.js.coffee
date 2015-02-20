app = @app

app.views.pastJourneys ?= {}

app.views.pastJourneys.ListItem = Backbone.View.extend
  template: HandlebarsTemplates['past_journeys/list_item']
  tagName: 'li'
  className: 'list-group-item'
  events:
    'click': 'onClick'
  initialize: ->
    @listenTo @model, 'destroy', @remove
  onClick: (e) ->
    e.preventDefault()
    view = new app.views.pastJourneys.Details(model: @model)
    @$el.closest('.panel-group').find('.list-group-item').removeClass('active')
    @$el.addClass('active')
    $('#main').html(view.render().el)
  render: ->
    attrs = @model.toJSON()
    attrs.start_at_day = ("0" + new Date(attrs.start_at).getDate()).slice(-2)
    attrs.start_at_month = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"][new Date(@model.get('start_at')).getMonth()]
    @$el.html @template attrs
    @
