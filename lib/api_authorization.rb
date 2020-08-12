# frozen_string_literal: true

require 'api_authorization/railtie'
require_relative 'api_authorization/cli'

module ApiAuthorization
  # Your code goes here...
  extend ActiveSupport::Concern

  included do |_mod|
    helper_method :check_role

    def self.enable_role_authorization
      before_action :check_role
    end

    # Filter the request with by controller and action to know if a user
    # can execute that action in that controller
    #
    # @return when the user is allowed
    def check_role
      puts 'AUTHORIZATION: Checking user roles' if Rails.env == 'development'
      roles = current_user.try(:roles)
      return if roles.find { |role| role.try(:name).try(:downcase) == 'superadmin' }

      # return render json: { error: 'You are not authorized' }, status: 403 if current_user.roles.empty?
      return not_authorized if current_user.roles.empty?

      current_user.roles.each do |role|
        return if role.permissions.where(controller: params['controller'], action: params['action']).count.positive?
      end

      # render json: { error: 'You are not authorized' }, status: 403
      not_authorized
    rescue StandardError => e
      # render json: { error: 'You are not authorized' }, status: 403
      not_authorized
    end

    # Filter the request params to know wether or not a user has
    # the right to push a certain value as a parameter.
    #
    # example:
    #
    # allowed_params = { anno: [2019] }
    # will remove from the params if the params hash contain a key :anno
    # with a value which is not 2019
    #
    # @params [Action::Parameters]
    # @return [Action::Parameters] without the disallowed key/values.
    def check_allowed_params(params, controller, action)
      roles = current_user.try(:permissions)
      return params if roles.find { |role| role.try(:name).try(:downcase) == 'superadmin' }

      rules = roles.where('controller = ? AND action = ? AND allowed_params IS NOT NULL', controller, action)

      return params if rules.nil? || rules.empty?

      rules.each do |rule|
        next if rule.allowed_params.nil?

        # puts "####### ruleS => #{rule.allowed_params.inspect}"
        rule.allowed_params.each do |k, v|
          puts " key: #{k}, value: #{v}"
          params.delete(k) unless Array(v).include?(params[k]) || v == params[k]
        end
      end

      params
    end

    # a wrapper around respond_to helper that returns
    # content as json, and html
    #
    # @params [String,Fixnum]
    # @return [ActionController::MimeResponds]
    def not_authorized(message = 'You are not authorized', status = 403)
      respond_to do |format|
        format.json do
          return render json: { error: message }, status: status
        end
        format.html do
          return render html: "<h2> Forbidden #{status}</h2>".html_safe, status: status
        end
      end
    end
  end
end
