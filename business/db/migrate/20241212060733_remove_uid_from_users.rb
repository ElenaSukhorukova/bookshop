class RemoveUidFromUsers < ActiveRecord::Migration[7.1]
  def change
    safety_assured { remove_column :users, :uid, :string }
  end
end
