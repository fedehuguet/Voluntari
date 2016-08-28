Rails.application.routes.draw do
  devise_for :users
  # API routes path
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
    	resources :users do
    		post 'add_project_to_user', on: :member
        delete 'delete_project_from_user', on: :member
    	end
    	resources :projects do
    		post 'add_user_to_project', on: :member
        delete 'delete_user_from_project', on: :member
        #post 'project_belongs', on: :member
    	end
    	resources :organizations
    end
  end  
end 