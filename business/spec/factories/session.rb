FactoryBot.define do
  factory :session do
    uid { SecureRandom.uuid }
    user { association :activated_user }
  end
end
