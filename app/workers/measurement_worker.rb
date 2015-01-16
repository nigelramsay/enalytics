class MeasurementWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: 2

  recurrence do
    minutely(1)
  end

  def perform
    SaveHeatmiserValues.new.save
  end
end