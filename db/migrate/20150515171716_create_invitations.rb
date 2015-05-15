class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.string :email
      t.string :secret_key

      t.timestamps null: false
    end
  end
end
