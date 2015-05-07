app = @app

app.collections.Journeys = Backbone.Collection.extend
  localStorage: new Backbone.LocalStorage("journeys")
  model: app.models.Journey
  comparator: (j1, j2) ->
    [d1, d2] = [j1.get('start_at'), j2.get('start_at')]
    if d1 > d2
      -1
    else if d1 < d2
      1
    else
      0
  populate: ->
    locs = _(["Aeropuerto T1", "Aeropuerto T4", "Sol", "Atocha Renfe", "Nuevos Ministerios", "Chamartin", "Cabify Spain"])
    vehicle_types = _(["Cabify Executive", "Cabify Lite", "Cabify Group", "Cabify Luxury"])
    _(100).times =>
      start_loc    = locs.sample()
      end_loc      = locs.sample()
      vehicle_type = vehicle_types.sample()
      start_at     = new Date(new Date().getTime() - Math.random() * 1000 * 3600 * 24 * 365)

      journey = @create(start_loc: start_loc, end_loc: end_loc, vehicle_type: vehicle_type, start_at: start_at)
      if Math.random() > 0.03
        journey.save(end_at: new Date(start_at.getTime() + Math.random() * 1000 * 3600 * 3))
