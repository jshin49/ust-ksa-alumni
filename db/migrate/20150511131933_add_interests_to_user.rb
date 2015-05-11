class AddInterestsToUser < ActiveRecord::Migration
  def change
    add_column :users, :interests, :integer, array: true, default: []
  end
end
