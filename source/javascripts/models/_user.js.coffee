app = @app

app.models.User = Backbone.Model.extend
  url: '/api/user'

  fetchForAuthorization: (auth) ->
    @fetch
      headers:
        'Authorization': "#{auth.get('token_type')} #{auth.get('access_token')}"
