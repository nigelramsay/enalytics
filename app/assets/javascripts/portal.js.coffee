window.Enalytics ?= {}

class Enalytics.Portal

  measurements: [
    ["/measurements/putnam_current_temperatures.json", "putnam_temperature"],
    ["/measurements/putnam_set_temperatures.json", "putnam_set_temperature"],
    ["/measurements/putnam_heating_status.json", "putnam_heating_status"],
    ["/measurements/karori_temperatures.json", "karori_temperature"]
  ]

  constructor: ->
    @loadMeasurements()
    @loadWind()

  loadMeasurements: =>
    for m in @measurements
      loader = new Enalytics.LoadMeasurements(url: m[0], targetElement: document.getElementById(m[1]))
      loader.load()

  loadWind: =>
    loader = new Enalytics.LoadWind(url: "/measurements/karori_wind", speedElement: document.getElementById('karori_wind_speed'), gustElement: document.getElementById('karori_wind_gust'), directionElement: document.getElementById('karori_wind_direction'))
    loader.load()

class Enalytics.LoadMeasurements
  constructor: (options) ->
    {@url, @targetElement} = options

  load: =>
    $.ajax({
      type: "GET"
      url: @url
      data: {
        period: 0.1
      }
      dataType: 'json'
      success: @populate
    })

  populate: (data) =>
    $(@targetElement).html(data[0] && data[0][1])

class Enalytics.LoadWind
  constructor: (options) ->
    {@url, @speedElement, @gustElement, @directionElement} = options

  load: =>
    $.ajax({
      type: "GET"
      url: @url
      data: {
        period: 0.1
      }
      dataType: 'json'
      success: @populate
    })

  populate: (data) =>
    $(@speedElement).html(data[0] && data[0][1])
    $(@gustElement).html(data[0] && data[0][2])
    $(@directionElement).html(data[0] && data[0][3])
