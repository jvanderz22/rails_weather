class AddFieldsToUsers < ActiveRecord::Migration
  def change_table(:users) do |t|
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :integer
    add_column :users, :phone_number, :string
  end
end
