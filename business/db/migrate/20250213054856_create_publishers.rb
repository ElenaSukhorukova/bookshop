class CreatePublishers < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    create_table :publishers do |t|
      t.string :name

      t.timestamps
    end

    add_reference :products, :publisher, index: { algorithm: :concurrently }
  end
end
