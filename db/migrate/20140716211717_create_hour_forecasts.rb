class CreateHourForecasts < ActiveRecord::Migration
  def change
    create_table :hour_forecasts do |t|
      t.datetime :time
      t.integer :temperature
      t.integer :wind
      t.decimal :precipitation
      t.decimal :humidity
      t.decimal :sky_cover

      t.timestamps
    end
  end
end
