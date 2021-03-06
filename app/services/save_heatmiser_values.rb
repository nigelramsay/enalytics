class SaveHeatmiserValues
	def initialize(args={})
	end

  def save
    ActiveRecord::Base.transaction do
      save_current_temperature
      save_set_temperature
      save_heating_status
    end
  end

  private

  def save_current_temperature
    if temp = heatmiser.current_temperature
      Measurement.putnam_current_temperatures.create! value: temp, recorded_at: current_time_without_seconds
    else
      $stderr.puts "Unable to acquire current_temperature"
    end
  end

  def save_set_temperature
    if temp = heatmiser.set_temperature
      Measurement.putnam_set_temperatures.create! value: temp, recorded_at: current_time_without_seconds
    else
      $stderr.puts "Unable to acquire set_temperature"
    end
  end

  def save_heating_status
    heating_status = heatmiser.heating?

    if heating_status != nil
      Measurement.putnam_heating_status.create! value: heating_status ? '1' : '0', recorded_at: current_time_without_seconds
    else
      $stderr.puts "Unable to acquire heating_status"
    end
  end

  def heatmiser
    @heatmiser ||= HeatMiser.new
  end

  def current_time_without_seconds
    @_time ||= begin
      now = Time.current
      Time.new(now.year, now.month, now.day, now.hour, now.min)
    end
  end
end