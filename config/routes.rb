Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions, only: %i[show new create destroy] do
    resources :answers, only: %i[show new create], shallow: true
  end
end
