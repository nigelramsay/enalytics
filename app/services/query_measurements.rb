class QueryMeasurements
  def initialize(period_in_seconds:)
    @period_in_seconds = period_in_seconds
  end
	
  def putnam_current_temperatures
    Measurement.putnam_current_temperatures.
                where('recorded_at >= ?', start_date).
                order('recorded_at desc').
                pluck(:recorded_at, :value).
                map {|t| [t[0], t[1].to_f] }
  end

  def putnam_set_temperatures
    Measurement.putnam_set_temperatures.
                where('recorded_at >= ?', start_date).
                order('recorded_at desc').
                pluck(:recorded_at, :value).
                map {|t| [t[0], t[1].to_f] }
  end

  def karori_temperatures
    Measurement.karori_temperatures.
                where('recorded_at >= ?', start_date).
                order('recorded_at desc').
                pluck(:recorded_at, :value).
                map {|t| [t[0], t[1].to_f] }
  end

  private

  attr_reader :period_in_seconds

  def start_date
    @_start_date ||= Time.current - period_in_seconds
  end
end