app = @app

app.views.LoginForm = Backbone.Marionette.ItemView.extend
  tagName: 'form'
  template: HandlebarsTemplates['login_form']
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
    @ui.submit.addClass('disabled')
  enable: ->
    @ui.submit.removeClass('disabled')
