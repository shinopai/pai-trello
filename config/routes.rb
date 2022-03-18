Rails.application.routes.draw do
  # root
  root 'home#index'

  # for spa route
  get 'lists/*other/card/new', to: 'home#index'
  get 'cards/*other/detail', to: 'home#index'
  get 'cards/*other/edit', to: 'home#index'

  # redirect
  get '/users' => redirect('/users/sign_up')

  # auth user
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # get current user
  namespace :api do
    namespace :v1 do
      get '/user', to: 'users#get_current_user', defaults: { format: 'json' }
    end
  end

  # lists route
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :lists, only: %i(index create update), defaults: { format: 'json' }
      end
      delete '/lists/:id', to: 'lists#destroy', defaults: { format: 'json' }
    end
  end

  # cards route
  namespace :api do
    namespace :v1 do
      resources :cards, only: %i(show edit update destroy), defaults: { format: 'json' } do
        member do
          get :detail
          get :edit_card
        end
      end
      resources :lists do
        resources :cards, only: %i(index create), defaults: { format: 'json' }
      end
    end
  end
end
