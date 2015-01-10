class EnforceMeasurementUniqueness < ActiveRecord::Migration
  def change
    add_index 'measurements', ['recorded_at', 'code'], unique: true
    add_index 'wind_measurements', ['recorded_at', 'code'], unique: true
  end
end
