Rails.application.routes.draw do
  resources :lists, except: [:new, :edit] do
    resources :tasks, except: [:new, :edit]
  end
end
