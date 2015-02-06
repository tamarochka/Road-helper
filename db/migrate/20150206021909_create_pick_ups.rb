class CreatePickUps < ActiveRecord::Migration
  def change
    create_table :pick_ups do |t|
      t.integer :location_id, null: false
      t.string :item, null: false
      t.string :quantity, null: false
      t.integer :user_id
      t.date :date
      t.timestamps
    end
  end
end
