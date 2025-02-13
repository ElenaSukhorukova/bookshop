Rails.application.routes.draw do
  devise_for :users

  root to: 'api/v1/office#index'

  get "up" => "rails/health#show", as: :rails_health_check
end
