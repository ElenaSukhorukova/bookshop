class AddRoleToUsers < ActiveRecord::Migration[8.0]
  def change
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
