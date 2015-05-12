class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.boolean :favorite
      t.timestamps null: false
    end
  end
end
