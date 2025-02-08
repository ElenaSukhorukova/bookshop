class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.date :birth_day
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.boolean :terms_of_service, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
