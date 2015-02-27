app = @app

app.views.journeys ?= {}

app.views.journeys.OrderForm = Backbone.Marionette.ItemView.extend
  triggers:
    submit: 'submit'
  getData: ->
    start_loc: @$('input[name="start_loc"]').val()
    end_loc: @$('input[name="end_loc"]').val()
    vehicle_type: @$('select[name="vehicle_type"]').val()
    start_at: new Date()
  reset: ->
    @$('.form-group.has-error').removeClass('has-error').find('span.help-block').remove()
    @$('input[name="start_loc"]').val('')
    @$('input[name="end_loc"]').val('')
    @$('select[name="vehicle_type"]').val('')
  onFormDataInvalid: (errors) ->
    @$('.form-group.has-error').removeClass('has-error').find('span.help-block').remove()
    _.each errors, (value, key) ->
      $formGroup = @$("[name=#{key}]").parent()
      $errorEl = $('<span>', class: 'help-block', text: value)
      $formGroup.addClass('has-error').append($errorEl)
