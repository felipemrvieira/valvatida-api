class SubdomainConstraint   
  def self.matches?(request)     
    request.subdomain.present? && request.subdomain != 'www'   
  end 
end 

Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      
      mount_devise_token_auth_for 'Student', at: 'student_auth'
      
      mount_devise_token_auth_for 'Teacher', at: 'teacher_auth', controllers: {
        # confirmations:      'devise_token_auth/confirmations',
        # passwords:          'devise_token_auth/passwords',
        # omniauth_callbacks: 'devise_token_auth/omniauth_callbacks',
        registrations:        'api/v1/teachers/registrations',
        sessions:             'api/v1/teachers/sessions',
        # token_validations:  'devise_token_auth/token_validations'
      }

      mount_devise_token_auth_for 'Admin', at: 'admin_auth', controllers: {
        # confirmations:      'devise_token_auth/confirmations',
        # passwords:          'devise_token_auth/passwords',
        # omniauth_callbacks: 'devise_token_auth/omniauth_callbacks',
        registrations:        'api/v1/admins/registrations',
        sessions:             'api/v1/admins/sessions',
        # token_validations:  'devise_token_auth/token_validations'
      }
      
      constraints SubdomainConstraint do     
        resources :teachers
      end
      resources :countries
      resources :states
      resources :cities
      resources :neighborhoods
      resources :addresses


      resources :courses
      resources :course_groups
      resources :enrollments
      resources :questions
      resources :schools
      resources :subjects
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
