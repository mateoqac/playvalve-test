Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post 'user/check_status' => 'users#check_status'
    end
  end
end
