FactoryBot.define do # rubocop:disable Layout/EndOfLine
  factory :user do
    email { Faker::Internet.email }
    password do
      Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true)
    end
    role { 'customer' }

    trait :activated do
      activated { true }
    end

    factory :activated_user, traits: %i[activated]
  end
end
