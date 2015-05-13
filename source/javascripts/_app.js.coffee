app = new Backbone.Marionette.Application
  models: {}
  collections: {}
  views: {}
  controllers: {}
  routers: {}
  regions:
    tabs:           '#tabs'
    sidebar:        '#sidebar'
    flash_messages: '#flash-messages'
    main:           '#main'

app.on 'start', ->
  Backbone.history.start()

@app = app
