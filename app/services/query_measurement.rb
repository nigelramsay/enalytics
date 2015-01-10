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
    [DAILY_ENERGY_USAGE_QUERY, [start_date, start_date.to_date, end_date.to_date]]
  end

  def end_date
    @_end_date ||= Time.current
  end

  def start_date
    @_start_date ||= end_date - period_in_seconds
  end

  DAILY_ENERGY_USAGE_QUERY =
    "WITH DAILY_ENERGY_USAGE AS (
       SELECT DATE_TRUNC('day', recorded_at) as recorded_date,
              sum(value) as minutes_on, 1 as qnum
       FROM measurements
       WHERE code = 'on'
       AND value = 1
       AND recorded_at >= $1
       GROUP BY recorded_date

       UNION

       SELECT recorded_date, 0 as minutes_on, 2 as qnum
       FROM generate_series($2::timestamp,
                            $3::timestamp, '1 day') as recorded_date
     )
     SELECT DISTINCT ON (recorded_date) recorded_date, minutes_on
     FROM DAILY_ENERGY_USAGE
     ORDER BY recorded_date, qnum"
end