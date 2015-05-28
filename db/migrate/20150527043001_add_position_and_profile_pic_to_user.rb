class AddPositionAndProfilePicToUser < ActiveRecord::Migration
  def change
    add_column :users, :position, :string
    add_column :users, :profile_pic_url, :string
    add_column :users, :linkedin_url, :string
  end
end
