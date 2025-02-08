# t.date 'birth_day'
# t.string 'first_name'
# t.string 'last_name'
# t.string 'phone_number'
# t.boolean 'terms_of_service', default: false
# t.bigint 'user_id'
# t.datetime 'created_at', null: false
# t.datetime 'updated_at', null: false
# t.index ['user_id'], name: 'index_profiles_on_user_id'

class Profile < ApplicationRecord
  belongs_to :user
end
