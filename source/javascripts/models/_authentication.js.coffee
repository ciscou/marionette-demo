app = @app

app.models.Authentication = Backbone.Model.extend
  url: '/api/authorization'
  authenticate: (username, password) ->
    @save
      username: username,
      password: password,
      grant_type: 'password',
      user_device: ''
    ,
      headers:
        'Authorization': 'Basic ODVhYzVmNmY0Y2JkNDJlZjlmMTdlNjE5ZTliNDI1N2I6OEE4Z1FmdzdpSFduUXJYQnlibm5fdw=='
        'X_BROWN_DISPATCHER': 'true'
      error: (model, xhr) ->
        model.validationError = xhr.responseJSON || { message: "Authentication failed!" }
