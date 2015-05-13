app = @app

app.controllers.Authentication =
  loginOrRegister: ->
    loginOrRegistrationView = new app.views.LoginOrRegistration()

    app.main.show(loginOrRegistrationView)

  login: ->
    authFormView = new app.views.AuthenticationForm()

    authFormView.on 'submit', ->
      authenticateAndFetchUser(authFormView)

    app.main.show(authFormView)

  register: ->
    registrationFormView = new app.views.RegistrationForm()

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

authenticateAndFetchUser = (authFormView) ->
  authFormView.disable()

  auth = new app.models.Authentication()
  promise = auth.authenticate(authFormView.getUsername(), authFormView.getPassword())

  promise.done ->
    fetchUserForAuthentication(auth)

  promise.fail ->
    app.flash_messages.show(new app.views.FlashMessage(message: auth.validationError.message))
    authFormView.enable()

fetchUserForAuthentication = (auth) ->
  user = new app.models.User()
  promise = user.fetchForAuthentication(auth)

  promise.done ->
    app.flash_messages.show(new app.views.FlashMessage(message: "Welcome, #{user.get('full_name')}!", level: 'success'))
    app.current_user = user
    app.vent.trigger('user:logged:in')

  promise.fail ->
    app.flash_messages.show(new app.views.FlashMessage(message: "ZOMG failed to fetch user"))
