app = @app

app.views.authentication ?= {}

app.views.authentication.LoginForm = Backbone.Marionette.ItemView.extend
  tagName: 'form'

  template: HandlebarsTemplates['authentication/login_form']

  triggers:
    submit: 'submit'

  ui:
    username: 'input#login_username'
    password: 'input#login_password'
    submit:   'input[type="submit"]'

  getUsername: ->
    @ui.username.val()

  getPassword: ->
    @ui.password.val()

  disable: ->
    @ui.submit.prop('disabled', true)

  enable: ->
    @ui.submit.prop('disabled', false)
