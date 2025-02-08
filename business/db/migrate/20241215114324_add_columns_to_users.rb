class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def up
    safety_assured do
      change_table :users, bulk: true do |t|
        t.string :google_secret
        t.integer :mfa_secret
        t.string :uid
      end
    end
  end

  def down
    safety_assured do
      change_table :users, bulk: true do |t|
        t.remove :google_secret, :mfa_secret, :uid
      end
    end
  end
end
