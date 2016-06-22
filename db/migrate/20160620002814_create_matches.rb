class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :finder_id
      t.integer :target_id
      t.float :target_x
      t.float :target_y
      t.float :target_z
      t.float :distance
      t.string :code

      t.timestamps null: false
    end
    add_index :matches, :finder_id
    add_index :matches, :target_id
  end
end
