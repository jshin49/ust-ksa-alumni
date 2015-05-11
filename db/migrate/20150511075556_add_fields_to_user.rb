class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :entrance_year, :datetime
    add_column :users, :graduation_year, :datetime
    add_column :users, :status, :string
    add_column :users, :name, :string
  end
end
