class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :industry_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
