class CreateDayForecasts < ActiveRecord::Migration
  def change
    create_table :day_forecasts do |t|
      t.string :day, limit: 20
      t.integer :high, limit: 3
      t.integer :low, limit: 3
      t.string :day_details, limit: 500
      t.string :night_details, limit: 500
      t.boolean :day_recorded
      t.boolean :night_recorded
      t.timestamps
    end
  end
end
