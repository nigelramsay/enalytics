class MeasurementWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    minutely(1)
  end

  def perform
    SaveHeatmiserValues.new.save
  end
end