class AddStoreToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :store_id, :integer
    add_index :line_items, :store_id
  end
end
