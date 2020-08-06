class ApplicationController < ActionController::Base
  include ActionController::Helpers
  include ApiAuthorization
  enable_role_authorization


  def current_user
    
  end
end
