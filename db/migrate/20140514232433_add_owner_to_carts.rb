class AddOwnerToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :owner_id, :integer
    add_index :carts, :owner_id
  end
end
