class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string   :email, null: false, index: { unique: true, name: 'unique_emails' }
      t.string   :password_digest
      t.string   :remember_digest
      t.string   :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end

    reversible do |direction|
      direction.up do
        safety_assured do
          execute <<-SQL.squish
            CREATE TYPE user_role
            AS ENUM ('employee', 'admin');
          SQL
        end

        add_column :users, :role, :user_role, default: 'employee'
      end

      direction.down do
        safety_assured { remove_column :users, :role, default: 'employee' }

        safety_assured do
          execute <<-SQL.squish
            DROP TYPE user_role;
          SQL
        end
      end
    end
  end
end
