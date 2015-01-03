class SaveKaroriWeather
  def initialize
    @station_id = 3772
  end

  def save
    save_current_temperature
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

  def save_current_temperature
    if latest_measurement.nil? || recorded_at > latest_measurement.recorded_at
      Measurement.create! value: current_temperature, code: 'karori_temp', recorded_at: recorded_at
    else
      $stderr.puts "No new Karori records"
    end
  end

  def harvest
    Harvest.new(station_id: station_id)
  end
end