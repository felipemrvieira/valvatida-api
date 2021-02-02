Rails.application.routes.draw do
  resources :enrollments
  mount_devise_token_auth_for 'Student', at: 'student_auth'

  mount_devise_token_auth_for 'Teacher', at: 'teacher_auth'
  as :teacher do
    # Define routes for Teacher within this block.
  end
  
  namespace :api do
    namespace :v1 do
      resources :course_groups
      resources :questions
      resources :subjects
      resources :courses
      resources :schools
      resources :addresses
      resources :neighborhoods
      resources :cities
      resources :states
      resources :countries
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
