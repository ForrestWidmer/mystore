class AddOwnerToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :owner_id, :integer
    add_index :orders, :owner_id
  end
end
