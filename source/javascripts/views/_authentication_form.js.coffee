app = @app

app.views.AuthenticationForm = Backbone.Marionette.ItemView.extend
  tagName: 'form'
  template: HandlebarsTemplates['authentication_form']
  triggers:
    submit: 'submit'
  ui:
    username: 'input#authentication_username'
    password: 'input#authentication_password'
    submit:   'input[type="submit"]'
  getUsername: ->
    @ui.username.val()
  getPassword: ->
    @ui.password.val()
  disable: ->
    @ui.submit.addClass('disabled')
  enable: ->
    @ui.submit.removeClass('disabled')
