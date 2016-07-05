class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :location
      t.date :birth_day
      t.text :about

      t.timestamps null: false
    end
  end
end
