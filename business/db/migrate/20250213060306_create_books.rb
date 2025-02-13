class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.integer :pages

      t.timestamps
    end
  end
end
