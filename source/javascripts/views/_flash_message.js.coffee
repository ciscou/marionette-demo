app = @app

app.views.FlashMessage = Backbone.Marionette.ItemView.extend
  className: 'alert alert-dismissible'

  initialize: (@message, @type = 'danger') ->

  template: HandlebarsTemplates['flash_message']

  onRender: ->
    @$el.addClass("alert-#{@type}").delay(2000).slideUp()

  serializeData: ->
    message: @message
