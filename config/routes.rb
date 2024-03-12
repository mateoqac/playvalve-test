Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create update] do
        collection do
          post 'check_status'
        end
      end
    end
  end
end
