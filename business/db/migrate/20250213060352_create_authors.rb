class CreateAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :authors do |t|
      t.string     :full_name, null: false
      t.string     :biography
      t.string     :native_country
      t.daterange  :life_expectancy

      t.timestamps
    end

    create_table :authors_books, id: false do |t|
      t.belongs_to :book
      t.belongs_to :author

      t.timestamps
    end
  end
end
