Rails.application.routes.draw do
  resources :clock_events, except: :show do
    collection do
      get 'user/:username', to: 'clock_events#user_events'
    end
  end

  root 'clock_events#index'
end
