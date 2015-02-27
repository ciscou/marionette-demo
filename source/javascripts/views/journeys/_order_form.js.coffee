app = @app

app.views.journeys ?= {}

app.views.journeys.OrderForm = Backbone.Marionette.ItemView.extend
  tagName: 'form'
  className: 'panel-body'
  template: HandlebarsTemplates['journeys/order_form']
  triggers:
    submit: 'submit'
  ui:
    start_loc: 'input[name="start_loc"]'
    end_loc: 'input[name="end_loc"]'
    vehicle_type: 'select[name="vehicle_type"]'
  getData: ->
    start_loc: @ui.start_loc.val()
    end_loc: @ui.end_loc.val()
    vehicle_type: @ui.vehicle_type.val()
    start_at: new Date()
  reset: ->
    @$('.form-group.has-error').removeClass('has-error').find('span.help-block').remove()
    @ui.start_loc.val('')
    @ui.end_loc.val('')
    @ui.vehicle_type.val('')
  onFormDataInvalid: (errors) ->
    @$('.form-group.has-error').removeClass('has-error').find('span.help-block').remove()
    _.each errors, (value, key) ->
      $formGroup = @ui[key].parent()
      $errorEl = $('<span>', class: 'help-block', text: value)
      $formGroup.addClass('has-error').append($errorEl)
