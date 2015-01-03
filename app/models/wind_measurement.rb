class WindMeasurement < ActiveRecord::Base
  validates :code, :speed, :gust_speed, :recorded_at, presence: true
end