module ArrayToEnumHash
  extend ActiveSupport::Concern

  class_methods do
    def array_to_enum_hash(a)
      a.reduce({}) { |acc, x| acc.update(x.to_sym => x.to_s) }
    end
  end
end
