app = @app

app.controllers.Authentication =
  login: ->
    authFormView = new app.views.AuthenticationForm()

    authFormView.on 'submit', ->
      authFormView.disable()
      auth = new app.models.Authentication()
      promise = auth.authenticate(authFormView.getUsername(), authFormView.getPassword())

      promise.done ->
        app.vent.trigger("user:logged:in")
        console.log("OK! :)", auth.attributes)
      promise.fail ->
        authFormView.enable()
        console.log("KO! :(", auth.validationError)

    app.main.show(authFormView)
