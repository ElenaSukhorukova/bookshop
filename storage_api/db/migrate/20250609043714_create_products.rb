class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.jsonb :decription
      t.string :productable_type
      t.integer :productable_id

      t.timestamps
    end

    reversible do |direction|
      direction.up do
        safety_assured do
          execute <<-SQL
            CREATE TYPE stock_state
            AS ENUM ('out_of_stock', 'in_stock', 'to_order', 'sold_out');
          SQL
        end

        add_column :products, :state, :stock_state
        add_index  :products, :state
      end

      direction.down do
        remove_index  :products, :state
        remove_column :products, :state

        safety_assured do
          execute <<-SQL
            DROP TYPE stock_state;
          SQL
        end
      end
    end
  end
end
