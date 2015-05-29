class AddUidAndProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string
    add_column :users, :provider, :string
  end
end
