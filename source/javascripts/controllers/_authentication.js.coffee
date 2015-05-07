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
    console.log("OK! :)", auth.attributes)
    fetchUserForAuthentication(auth)

  promise.fail ->
    console.log("KO! :(", auth.validationError)
    authFormView.enable()

fetchUserForAuthentication = (auth) ->
  user = new app.models.User()
  promise = user.fetchForAuthentication(auth)

  promise.done ->
    console.log user.attributes
    app.current_user = user
    app.vent.trigger("user:logged:in")

  promise.fail ->
    console.log("ZOMG failed to fetch user")
