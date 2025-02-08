RSpec.shared_context 'when it needs an email and password' do
  let(:email) { Faker::Internet.email(domain: 'example.com') }
  let(:password) { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true) }
end
