class CreateWindMeasurements < ActiveRecord::Migration
  def change
    create_table :wind_measurements do |t|
      t.decimal :speed, null: false
      t.string :direction
      t.decimal :gust_speed, null: false
      t.datetime :recorded_at, null: false
      t.string :code, null: false
    end
  end
end
