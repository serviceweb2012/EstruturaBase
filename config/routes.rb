EstruturaBase::Application.routes.draw do
  root :to => "home#index"

  #rotas erradas
  #match '*path' => 'admin/four_oh_fours#add_request'

  #rotas publicas

  #rotas fixas
  match '/admin/home/:id/enabled_disabled' => "admin/home#enabled_disabled"
  match '/admin/home/disabled_all/:modelo/:ids' => "admin/home#disabled_all"
  match '/admin/home/delete_all/:modelo/:ids' => "admin/home#delete_all"

  #rotas devise
  devise_for :users,:controllers => {
                        :sessions => "admin/sessions",
                        :unlocks => "admin/unlocks",
                        :passwords => "admin/passwords"
                      }
  #rotas admin
  namespace :admin do
    root :to => "home#index"

    resources :users
    resources :home do
      post 'set_session',:on => :collection
      post 'enabled_disabled',:on => :member
    end

    resources :four_oh_fours
    resources :locations do
      get 'delete_image',:on => :member
    end

    resources :menus do
      collection do
        get 'ordenar_menus'
        get 'sort'
      end
    end

    resources :permissions do
      get 'find_actions_by_model',:on => :collection
    end

    resources :roles

    resources :sub_menus do
      collection do
        get 'ordenar_sub_menus'
        get 'sort'
        get 'find_sub_menus_by_menu'
      end
    end

  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

