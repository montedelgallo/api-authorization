class AuthorizationController < ApplicationController
  # before_action :authenticate_user!

  include ActionController::Helpers
  include ApiAuthorization
  enable_role_authorization
end
