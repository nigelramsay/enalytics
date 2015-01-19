class Api::MeasurementsController < Api::BaseController
  def energy_usage
    render json: QueryEnergyUsage.new(period_in_seconds: period_in_seconds).energy_usage
  end

  def putnam_current_temperatures
  	render json: QueryMeasurements.new(period_in_seconds: period_in_seconds).putnam_current_temperatures
  end

  def putnam_set_temperatures
  	render json: QueryMeasurements.new(period_in_seconds: period_in_seconds).putnam_set_temperatures
  end

  def putnam_heating_status
    render json: QueryMeasurements.new(period_in_seconds: period_in_seconds).putnam_heating_status
  end
    
  def karori_temperatures
  	render json: QueryMeasurements.new(period_in_seconds: period_in_seconds).karori_temperatures
  end

  def karori_wind
    render json: QueryWindMeasurements.new(period_in_seconds: period_in_seconds).karori
  end

  private

  def period_in_seconds
    params[:period] && params[:period].to_f.days || 14.days
  end
end
