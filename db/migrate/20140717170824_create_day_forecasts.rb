class CreateDayForecasts < ActiveRecord::Migration
  def change
    create_table :day_forecasts do |t|
      t.string :day, limit: 20
      t.integer :temperature, limit: 3
      t.string :temperature_type, limit: 10
      t.timestamps
    end
  end
end
