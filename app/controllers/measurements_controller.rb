class MeasurementsController < ApplicationController
  def energy_usage
    render(json: QueryMeasurement.new(period_in_seconds: period_in_seconds).energy_usage)
  end

  private

  def period_in_seconds
    params[:period] && params[:period].to_i.days || 14.days
  end
end
