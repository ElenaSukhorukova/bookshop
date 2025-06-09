class CreateStorageItems < ActiveRecord::Migration[8.0]
  def change
    create_table :storage_items do |t|
      t.decimal :cost, precision: 5, scale: 2, null: false, default: 0
      t.decimal :shipping, precision: 5, scale: 2, null: false, default: 0
      t.decimal :price, precision: 5, scale: 2, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.belongs_to :product

      t.timestamps
    end
  end
end
