class CreateCurrentForecasts < ActiveRecord::Migration
  def change
    create_table :current_forecasts do |t|
      t.integer :temperature
      t.string :condition
      t.string :wind_speed
      t.integer :humidity

      t.timestamps
    end
  end
end
