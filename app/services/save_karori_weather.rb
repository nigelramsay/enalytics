class SaveKaroriWeather
  def initialize
    @station_id = 3772
  end

  def save
    save_current_conditions
  end

  private

  attr_reader :station_id

  def current_temperature
    harvest.temperature
  end

  def recorded_at
    harvest.recorded_at
  end

  def latest_measurement
    Measurement.where(code: 'karori_temp').order('recorded_at desc').first
  end

  def save_current_conditions
    if latest_measurement.nil? || recorded_at > latest_measurement.recorded_at
      measurement = Measurement.create! value: current_temperature, code: 'karori_temp', recorded_at: recorded_at
      $stderr.puts "Karori data... current_temperature #{measurement.value} recorded_at #{measurement.recorded_at}"

      wind = WindMeasurement.create! code: 'karori',
                                     speed: harvest.wind_speed,
                                     gust_speed: harvest.wind_gust,
                                     direction: harvest.wind_direction,
                                     recorded_at: harvest.recorded_at
      $stderr.puts "Karori wind... speed #{wind.speed} #{wind.direction} gust #{wind.gust_speed}"
    else
      $stderr.puts "No new Karori records"
    end
  end

  def harvest
    @_harvest ||= Harvest.new(station_id: station_id)
  end
end