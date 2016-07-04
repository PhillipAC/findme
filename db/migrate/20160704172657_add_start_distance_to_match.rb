class AddStartDistanceToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :startDistance, :float
    add_column :matches, :state, :integer
  end
end
