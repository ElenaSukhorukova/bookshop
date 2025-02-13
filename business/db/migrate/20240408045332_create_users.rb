# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string   :email, null: false, index: { unique: true, name: 'unique_emails' }
      t.string   :password_digest
      t.string   :remember_digest
      t.boolean  :activated, default: false, null: false
      t.datetime :activated_at
      t.string   :activation_digest
      t.string   :reset_digest
      t.datetime :reset_sent_at
      t.string   :users, :uid
      t.string   :provider
      t.jsonb    :provider_settings

      t.timestamps
    end

    reversible do |direction|
      direction.up do
        safety_assured do
          execute <<-SQL.squish
            CREATE TYPE user_role
            AS ENUM ('customer', 'employee', 'admin');
          SQL
        end

        add_column :users, :role, :user_role, default: 'customer'
      end

      direction.down do
        safety_assured { remove_column :users, :role, default: 'customer' }

        safety_assured do
          execute <<-SQL.squish
            DROP TYPE user_role;
          SQL
        end
      end
    end
  end
end
