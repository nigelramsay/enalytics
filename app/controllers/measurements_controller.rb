class MeasurementsController < ApplicationController
  def energy_usage
    render(json: QueryMeasurement.new(period_in_seconds: period).energy_usage)
  end

  private

  def period
    params[:period] && params[:period].to_i.seconds || 14.days
  end
end
