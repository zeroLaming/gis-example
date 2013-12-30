Aiesec::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :opportunities, except: [:new, :edit] do
        resources :applications, except: [:new, :edit]
      end
      root to: "welcome#index"
    end
  end
  
  root to: "welcome#index"
end
