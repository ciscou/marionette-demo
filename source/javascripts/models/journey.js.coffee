app = @app

app.models.Journey = Backbone.Model.extend
  defaults:
    start_loc: ''
    end_loc: ''
    vehicle_type: ''
    start_at: null
    end_at: null
  finish: ->
    @save('end_at', new Date())
  isActive: ->
    !@isPast()
  isPast: ->
    @has('end_at')
  validate: (attrs, opts) ->
    errors = {}
    unless attrs.start_loc
      errors.start_loc = "Donde quieres que te recojamos?"
    unless attrs.end_loc
      errors.end_loc = "Donde quieres ir?"
    unless attrs.vehicle_type
      errors.vehicle_type = "Elije una categoria de vehiculo"
    if _.isEmpty(errors)
      undefined
    else
      errors
