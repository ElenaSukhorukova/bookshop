class RemoveExpiresInFromSessions < ActiveRecord::Migration[7.1]
  def change
    safety_assured { remove_column :sessions, :expires_in, :datetime }
  end
end
