Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :attachments, only: :destroy
  resources :achievements, only: :index do
    collection do
      get :received
    end
  end

  resources :questions, only: %i[show new create destroy update] do
    resources :answers, only: %i[show new create destroy update], shallow: true do
      member do
        patch :best
      end
    end
  end
end
