class CreateGenres < ActiveRecord::Migration[8.0]
  def change
    create_table :genres do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end

    create_table :books_genres, id: false do |t|
      t.belongs_to :book
      t.belongs_to :genre

      t.timestamps
    end
  end
end
