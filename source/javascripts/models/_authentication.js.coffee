app = @app

app.models.Authentication = Backbone.Model.extend
  url: '/api/authorization'
  authenticate: (username, password) ->
    @sync 'create', this,
     headers:
       'Authorization': 'Basic ODVhYzVmNmY0Y2JkNDJlZjlmMTdlNjE5ZTliNDI1N2I6OEE4Z1FmdzdpSFduUXJYQnlibm5fdw=='
     success: (data, status, xhr) =>
       @set(data)
     error: (xhr, status, response) =>
       @validationError = xhr.responseJSON
     attrs:
       username: username,
       password: password,
       grant_type: 'password',
       user_device: ''
