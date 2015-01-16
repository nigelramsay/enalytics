class QueryWindMeasurements
  def initialize(period_in_seconds:)
    @period_in_seconds = period_in_seconds
  end
	
  def karori
    WindMeasurement.karori.
                    where('recorded_at >= ?', start_date).
                    order('recorded_at desc').
                    pluck(:recorded_at, :speed, :gust_speed, :direction).
                    map {|t| [t[0], t[1].to_f, t[2].to_f, t[3]] }
  end

  private

  attr_reader :period_in_seconds

  def start_date
    @_start_date ||= Time.current - period_in_seconds
  end
end