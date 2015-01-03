class KaroriTemperatureWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly.minute_of_hour(0, 15, 30, 45)
  end

  def perform
    SaveKaroriWeather.new.save
  end
end