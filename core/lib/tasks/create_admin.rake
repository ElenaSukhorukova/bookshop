# run it with command: rails create_admin:creation

namespace :create_admin do
  task :creation => [ :environment ] do
    password = '!$jlO123OF@'
    encrypted_password = BCrypt::Password.create(password)

    User.create!(
      email: 'admin@admin.com',
      password: password,
      encrypted_password: encrypted_password,
      role: 'admin'
    )
  end
end
