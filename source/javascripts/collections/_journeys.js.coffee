app = @app

app.collections.Journeys = Backbone.Collection.extend
  localStorage: new Backbone.LocalStorage("journeys")
  model: app.models.Journey
  comparator: 'start_at'
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
