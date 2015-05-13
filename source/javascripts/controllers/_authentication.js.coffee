app = @app

app.controllers.Authentication =
  loginOrRegister: ->
    loginOrRegistrationView = new app.views.authentication.LoginOrRegistration()

    app.main.show(loginOrRegistrationView)

  login: ->
    loginFormView = new app.views.authentication.LoginForm()

    loginFormView.on 'submit', ->
      authenticateAndFetchUser(loginFormView)

    app.main.show(loginFormView)

  register: ->
    registrationFormView = new app.views.authentication.RegistrationForm()

    registrationFormView.on 'submit', ->
      registrationFormView.disable()

      user = new app.models.User(registrationFormView.getData())
      registering = user.save null,
        error: (model, xhr) ->
          model.validationError = xhr.responseJSON || { message: "Registration failed" }

      registering.done ->
        app.flash_messages.show(new app.views.FlashMessage(message: "You've been registered successfully! Please, log in", level: 'success'))
        app.vent.trigger('user:registered')

      registering.fail ->
        app.flash_messages.show(new app.views.FlashMessage(message: user.validationError.message))
        registrationFormView.onFormDataInvalid(user.validationError.errors)
        registrationFormView.enable()

    app.main.show(registrationFormView)

authenticateAndFetchUser = (loginFormView) ->
  loginFormView.disable()

  auth = new app.models.Authorization()
  promise = auth.authenticate(loginFormView.getUsername(), loginFormView.getPassword())

  promise.done ->
    fetchUserForAuthorization(auth)

  promise.fail ->
    app.flash_messages.show(new app.views.FlashMessage(message: auth.validationError.message))
    loginFormView.enable()

fetchUserForAuthorization = (auth) ->
  user = new app.models.User()
  promise = user.fetchForAuthorization(auth)

  promise.done ->
    app.flash_messages.show(new app.views.FlashMessage(message: "Welcome, #{user.get('full_name')}!", level: 'success'))
    app.current_user = user
    app.vent.trigger('user:logged:in')

  promise.fail ->
    app.flash_messages.show(new app.views.FlashMessage(message: "ZOMG failed to fetch user"))
