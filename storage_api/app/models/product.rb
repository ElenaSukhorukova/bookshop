class Product < ApplicationRecord
  delegated_type :productable, types: %w[Book Magazine], dependent: :destroy

  has_many :storage_items

  def self.create_with_book(params)
    book = Book.find_or_create_by(params)
    product = new(params.slice(self.column_names))

    product.productable = book
    product.save!
  end

  def self.create_with_customer(params)
    create! productable: Magazine.new(params)
  end
end
