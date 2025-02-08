class ApplicationRecord < ActiveRecord::Base
  include EnumLists
  include ArrayToEnumHash

  primary_abstract_class
end
