class AddOwnerToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :owner_id, :integer
    add_index :line_items, :owner_id
  end
end
