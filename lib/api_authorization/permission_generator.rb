# frozen_string_literal: true

module ApiAuthorization
  class PermissionGenerator
    def initialize
      @routes = []

      Rails.application.routes.routes.map do |r|
        route = {
          url: r.defaults[:controller],
          controller: r.defaults[:controller],
          action: r.defaults[:action],
          method: r.verb
        }

        @routes.push(route)
      end
      generate_routes
    end

    def call
      @routes.group_by { |n| n[:controller] }.each { |_k, v| v.uniq! }
    end

    def generate_routes
      puts 'Populating permissions_table with routes of the application' if Rails.env == 'development'
      begin
        Permission.destroy_all
      rescue NameError => e
        puts 'No Permission table was found please run "rails api_auth:install" first to generate the tables'
        puts e.backtrace if Rails.env == 'development'
        return
      end

      @routes.each do |k|
        Permission.create!(controller: k[:controller], action: k[:action])
      end
      puts 'Done!' if Rails.env == 'development'
    end

    private

    attr_accessor :routes
  end
end
