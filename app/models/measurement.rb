class Measurement < ActiveRecord::Base	
  validates :code, :value, :recorded_at, presence: true

  scope :karori_temperatures, -> { where(code: 'karori_temp') }
  scope :putnam_current_temperatures, -> { where(code: 'actual') }
  scope :putnam_set_temperatures, -> { where(code: 'set') }
  scope :putnam_heating_status, -> { where(code: 'on') }
end