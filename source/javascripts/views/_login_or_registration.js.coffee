app = @app

app.views.LoginOrRegistration = Backbone.Marionette.ItemView.extend
  template: HandlebarsTemplates['login_or_registration']
