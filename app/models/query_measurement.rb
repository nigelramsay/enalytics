class QueryMeasurement
  def initialize(period_in_seconds:)
    @period_in_seconds = period_in_seconds
  end

  def energy_usage
    ActiveRecord::Base.connection.raw_connection.exec_params(*energy_usage_query).values
  end

  private

  attr_reader :period_in_seconds

  def energy_usage_query
    [ENERGY_USAGE_QUERY, [Time.current, Time.current - period_in_seconds]]
  end

  ENERGY_USAGE_QUERY =
    "SELECT (EXTRACT(EPOCH FROM ($1 - recorded_at))/(60*60*24))::integer as day_num, sum(value) from measurements
     WHERE code = 'on'
     AND value = 1
     AND recorded_at >= $2
     GROUP BY day_num
     ORDER BY day_num"
end