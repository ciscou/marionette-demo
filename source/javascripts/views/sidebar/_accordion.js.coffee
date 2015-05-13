app = @app

app.views.sidebar ?= {}

app.views.sidebar.Accordion = Backbone.Marionette.LayoutView.extend
  id: 'accordion'

  className: 'panel-group'

  template: HandlebarsTemplates['sidebar/accordion']

  events:
    'click .panel-title a': 'onPanelTitleClicked'

  regions:
    order: '#order'
    active: '#active'
    past: '#past'

  onRender: ->
    @$el.on 'show.bs.collapse', =>
      @$('.panel-collapse.in').collapse('hide')

    @$("##{@options.current}").collapse('show')

  onPanelTitleClicked: (e) ->
    e.preventDefault()

    $a = $(e.target)
    @$("##{$a.data('target')}").collapse('toggle')

    app.vent.trigger 'navigate:journeys', $a.data('target')
