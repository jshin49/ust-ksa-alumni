class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.string :school
      t.string :code

      t.timestamps null: false
    end
  end
end
