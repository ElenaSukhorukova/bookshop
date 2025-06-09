class Book < ApplicationRecord
  include Productable

  FORMATS = %w[paper pdf epub audio online].freeze

  store :description, accessors: %i[formats language published context synopsis], coder: JSON, prefix: :descr
end
