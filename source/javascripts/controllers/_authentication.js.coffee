app = @app

app.controllers.Authentication =
  login: ->
    auth = new app.models.Authentication()
    promise = auth.authenticate("francismpp@gmail.com", "s3cr3t")
    promise.done -> console.log("OK! :)")
    promise.fail -> console.log("KO! :(")
