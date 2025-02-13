class Book < ApplicationRecord
  include Profilable

  has_and_belongs_to_many :authors, -> { extending Validations::ExtentionUniqCollection }
  has_and_belongs_to_many :genres, -> { extending Validations::ExtentionUniqCollection }

  FORMATS = %w[paper pdf epub audio online].freeze

  accepts_nested_attributes_for :authors, :genres

  store :description, accessors: %i[formats language published context synopsis], coder: JSON, prefix: :descr
end
