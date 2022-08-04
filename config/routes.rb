Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  concern :votable do
    member do
      patch :change_rating
      delete :cancel
    end
  end

  resources :attachments, only: :destroy
  resources :achievements, only: :index do
    collection do
      get :received
    end
  end

  resources :questions, only: %i[show new create destroy update], concerns: [:votable] do
    resources :answers, only: %i[show new create destroy update], shallow: true, concerns: [:votable] do
      member do
        patch :best
      end
    end
  end
end
