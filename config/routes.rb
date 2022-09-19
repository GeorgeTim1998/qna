require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users
  root to: 'questions#index'

  concern :votable do
    member do
      patch :change_rating
      delete :cancel
    end
  end

  concern :commentable do
    resource :comments, only: :create, shallow: true
  end

  resources :attachments, only: :destroy
  resources :achievements, only: :index do
    collection do
      get :received
    end
  end

  resources :questions, only: %i[show new create destroy update], concerns: %i[votable commentable] do
    resources :answers, only: %i[show new create destroy update], shallow: true, concerns: %i[votable commentable] do
      member do
        patch :best
      end
    end

    resources :subscriptions, only: %i[create destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: :index do
        get :me, on: :collection
      end

      resources :questions, except: %i[new edit] do
        resources :answers, except: %i[new edit], shallow: true
      end
    end
  end
end
