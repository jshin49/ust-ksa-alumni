class AddLocationAndOrganizationToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :organization, :string
  end
end
