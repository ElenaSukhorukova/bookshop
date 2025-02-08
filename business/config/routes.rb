require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    user_id = request.session[:user_id] ||
              request.cookie_jar.encrypted[:user_id]

    User.find_by(id: user_id)&.admin?
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' # , constraints: AdminConstraint.new

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root to: 'api/v1/external/store#shop_window'

    get 'about', to: 'api/v1/external/store#about'
    get 'contacts', to: 'api/v1/external/store#contacts'

    scope module: 'api' do
      scope module: 'v1' do
        scope module: 'users' do
          get  :signin, to: 'sessions#new'
          post :signin, to: 'sessions#create'
          post :signout, to: 'sessions#destroy'
          get '/auth/:provider/callback', to: 'sessions#omniauth'

          resources :account_activations, only: %i[edit]
          resources :password_resets, only: %i[new create edit update]
          resources :mfa_sessions, only: %i[new create]

          resources :users, except: %i[index destroy] do
            resources :profiles, except: %i[index], shallow: true
          end
        end
      end
    end
  end

  get "healthz" => "rails/health#show", as: :rails_health_check
end
