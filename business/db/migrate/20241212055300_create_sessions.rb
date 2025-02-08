class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.string :uid, null: false, index: { unique: true, name: 'unique_sessions' }
      t.datetime :expires_in
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
