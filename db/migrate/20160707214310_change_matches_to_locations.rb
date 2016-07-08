class ChangeMatchesToLocations < ActiveRecord::Migration
  def change
    rename_table :matches, :locations
  end
end
