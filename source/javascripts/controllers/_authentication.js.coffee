app = @app

app.controllers.Authentication =
  login: ->
    authFormView = new app.views.AuthenticationForm()

    authFormView.on 'submit', ->
      authenticateAndFetchUser(authFormView)

    app.main.show(authFormView)

authenticateAndFetchUser = (authFormView) ->
  authFormView.disable()

  auth = new app.models.Authentication()
  promise = auth.authenticate(authFormView.getUsername(), authFormView.getPassword())

  promise.done ->
    fetchUserForAuthentication(auth)

  promise.fail ->
    app.flash_messages.show(new app.views.FlashMessage(auth.validationError.message))
    authFormView.enable()

fetchUserForAuthentication = (auth) ->
  user = new app.models.User()
  promise = user.fetchForAuthentication(auth)

  promise.done ->
    app.flash_messages.show(new app.views.FlashMessage("Welcome, #{user.get('full_name')}!", "success"))
    app.current_user = user
    app.vent.trigger("user:logged:in")

  promise.fail ->
    app.flash_messages.show(new app.views.FlashMessage("ZOMG failed to fetch user"))
