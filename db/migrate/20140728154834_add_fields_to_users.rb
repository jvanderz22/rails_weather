class AddFieldsToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      add_column :users, :city, :string
      add_column :users, :state, :string
      add_column :users, :zip, :string
      add_column :users, :phone_number, :string
      add_column :users, :send_email, :boolean
      add_column :users, :send_text, :boolean
    end
  end
end
