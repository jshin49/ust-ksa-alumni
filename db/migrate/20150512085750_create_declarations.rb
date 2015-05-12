class CreateDeclarations < ActiveRecord::Migration
  def change
    create_table :declarations do |t|
      t.integer :major_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
