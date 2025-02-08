class RemoveUsersFromUsers < ActiveRecord::Migration[7.1]
  def change
    safety_assured { remove_column :users, :users, :string }
  end
end
