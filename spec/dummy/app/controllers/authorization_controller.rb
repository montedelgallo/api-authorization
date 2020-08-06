class AuthorizationController < ApplicationController
  include ActionController::Helpers
  include ApiAuthorization
  enable_role_authorization
end
