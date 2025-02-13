class Product < ApplicationRecord
  delegated_type :productable, types: %w[Book Magazine], dependent: :destroy

  def self.create_with_book(params)
    create! profilable: Book.new(params)
  end

  def self.create_with_customer(params)
    create! profilable: Magazine.new(params)
  end
end
