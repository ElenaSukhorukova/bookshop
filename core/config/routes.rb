require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'api/v1/office#index'

  get "up" => "rails/health#show", as: :rails_health_checks
end
