Rails.application.routes.draw do
  resources :clock_events, except: :show

  resources :users do
    collection do
      get ':username', to: 'users#user_events'
      put ':username/log_user_event', to: 'users#log_user_event'
    end
  end

  root 'clock_events#index'
end
