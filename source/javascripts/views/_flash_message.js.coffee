app = @app

app.views.FlashMessage = Backbone.Marionette.ItemView.extend
  className: 'alert alert-dismissible'

  template: HandlebarsTemplates['flash_message']

  onRender: ->
    @$el.addClass("alert-#{@options.level || "danger"}").delay(2000).slideUp()

  serializeData: ->
    message: @options.message
