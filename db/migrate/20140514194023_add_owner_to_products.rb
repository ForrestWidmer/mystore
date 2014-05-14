class AddOwnerToProducts < ActiveRecord::Migration
  def change
    add_column :products, :owner_id, :integer
    add_index :products, :owner_id
  end
end
