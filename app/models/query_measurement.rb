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
    [ENERGY_USAGE_QUERY, [start_date, start_date.to_date, end_date.to_date]]
  end

  def end_date
    @_end_date ||= Time.current
  end

  def start_date
    @_start_date ||= end_date - period_in_seconds
  end

  ENERGY_USAGE_QUERY =
    "SELECT DATE_TRUNC('day', recorded_at) as recorded_date, sum(value) as minutes_on
     FROM measurements
     WHERE code = 'on'
     AND value = 1
     AND recorded_at >= $1
     GROUP BY recorded_date

     UNION

     SELECT recorded_date, 0 as minutes_on
     FROM generate_series($2::timestamp,
                          $3::timestamp, '1 day') as recorded_date

     ORDER BY recorded_date"
end