module Profilable
  extend ActiveSupport::Concern

  included do
    has_one :product, as: :productable, touch: true
  end
end