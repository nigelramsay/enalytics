class SaveKaroriWeather
  def initialize
    @station_id = 3772
  end

  def save
    save_temperature_conditions if updated_temperature_data?
    save_wind_conditions if updated_wind_data?
  end

  def updated_wind_data?
    latest_wind_measurement.nil? || station_data_updated_at > latest_wind_measurement.recorded_at
  end

  def updated_temperature_data?
    latest_temperature_measurement.nil? || station_data_updated_at > latest_temperature_measurement.recorded_at
  end

  private

  attr_reader :station_id

  def station_data_updated_at
    harvest.recorded_at
  end

  def latest_temperature_measurement
    Measurement.where(code: 'karori_temp').order('recorded_at desc').first
  end

  def latest_wind_measurement
    WindMeasurement.where(code: 'karori').order('recorded_at desc').first
  end

  def save_wind_conditions
    wind = WindMeasurement.find_or_initialize_by code: 'karori',
                                                 recorded_at: harvest.recorded_at

    wind.speed = harvest.wind_speed
    wind.gust_speed = harvest.wind_gust
    wind.direction = harvest.wind_direction

    wind.save!

    $stderr.puts "Karori wind... speed #{wind.speed} #{wind.direction} gust #{wind.gust_speed}"
  end

  def save_temperature_conditions
    measurement = Measurement.find_or_initialize_by code: 'karori_temp', recorded_at: station_data_updated_at

    measurement.value = harvest.temperature

    measurement.save!

    $stderr.puts "Karori data... current_temperature #{measurement.value} recorded_at #{measurement.recorded_at}"
  end

  def harvest
    @_harvest ||= Harvest.new(station_id: station_id)
  end
end