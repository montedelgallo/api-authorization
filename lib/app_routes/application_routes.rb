# frozen_string_literal: true

module AppRoutes
  class ApplicationRoutes
    def initialize
      @routes = []

      Rails.application.routes.routes.map do |r|
        route = {
          url: r.defaults[:controller],
          controller: r.defaults[:controller],
          action: r.defaults[:action],
          method: r.verb
        }
        # rotta_finale = {
        #   controller: r.defaults[:controller],
        #   action: r.defaults[:action]
        # }
        # check = rotta[:controller]
        # verb = rotta[:method]
        # action = rotta[:action]
        # if check && verb != 'PATCH' && action != 'new' && action != 'edit'
        #   @routes.push(rotta_finale) if check.include? 'api/v1'
        # end

        @routes.push(route)
      end
      generate_routes
    end

    def call
      @routes.group_by { |n| n[:controller] }.each { |_k, v| v.uniq! }
    end

    def generate_routes
      puts 'Populating permissions_table with routes of the application' if Rails.env == 'development'
      Permission.destroy_all
      @routes.each do |k|
        Permission.create!(controller: k[:controller], action: k[:action])
      end
      puts 'Done!' if Rails.env == 'development'
    end

    private

    attr_accessor :routes
  end
end
