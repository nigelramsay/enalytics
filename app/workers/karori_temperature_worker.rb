class KaroriTemperatureWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    minutely(10)
  end

  def perform
    SaveKaroriWeather.new.save
  end
end