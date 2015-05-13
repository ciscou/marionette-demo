app = @app

app.views.authentication ?= {}

app.views.authentication.LoginOrRegistration = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['authentication/login_or_registration']
