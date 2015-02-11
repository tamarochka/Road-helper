class AddCustomerColumnToPickups < ActiveRecord::Migration
  def change
    add_column :pick_ups, :customer_id, :integer
  end
end
