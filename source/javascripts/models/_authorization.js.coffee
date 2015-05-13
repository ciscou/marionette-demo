app = @app

app.models.Authorization = Backbone.Model.extend
  url: '/api/authorization'
  authenticate: (username, password) ->
    @save
      username: username
      password: password
      grant_type: 'password'
    ,
      headers:
        'Authorization': 'Basic ODVhYzVmNmY0Y2JkNDJlZjlmMTdlNjE5ZTliNDI1N2I6OEE4Z1FmdzdpSFduUXJYQnlibm5fdw=='
      error: (model, xhr) ->
        model.validationError = xhr.responseJSON || { message: "Authentication failed!" }
