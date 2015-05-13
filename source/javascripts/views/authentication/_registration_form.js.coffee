app = @app

app.views.authentication ?= {}

app.views.authentication.RegistrationForm = Backbone.Marionette.ItemView.extend
  tagName: 'form'

  template: HandlebarsTemplates['authentication/registration_form']

  events:
    'change @ui.mobile_cc': 'onMobileCCChanged'

  triggers:
    submit: 'submit'

  ui:
    name:       '#registration_name'
    surname:    '#registration_surname'
    email:      '#registration_email'
    password:   '#registration_password'
    mobile_cc:  '#registration_mobile_cc'
    mobile_num: '#registration_mobile_num'
    mobile:     '#registration_mobile_num' # repeated because validation says mobile instead of mobile_num???
    submit:     'input[type="submit"]'

  onRender: ->
    @ui.mobile_cc.val('34').trigger('change')

  serializeData: ->
    countries: [
      { code:  "56", name: "Chile" }
      { code:  "51", name: "Lima" }
      { code: "521", name: "Mexico" }
      { code:  "34", name: "Spain" }
    ]

  onMobileCCChanged: ->
    @$('.input-group-addon.mobile-cc').text("+#{@ui.mobile_cc.val()}")

  getData: ->
    name: @ui.name.val()
    surname: @ui.surname.val()
    email: @ui.email.val()
    password: @ui.password.val()
    mobile_cc: @ui.mobile_cc.val()
    mobile_num: @ui.mobile_num.val()

  onFormDataInvalid: (errors) ->
    @$('.form-group.has-error').removeClass('has-error').find('span.help-block').remove()
    _.each errors, (value, key) =>
      $formGroup = @ui[key].parent()
      $errorEl = $('<span>', class: 'help-block', text: value.join(", "))
      $formGroup.addClass('has-error').append($errorEl)

  disable: ->
    @ui.submit.prop('disabled', true)

  enable: ->
    @ui.submit.prop('disabled', false)
