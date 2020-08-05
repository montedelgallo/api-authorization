# frozen_string_literal: true

require_relative './../app_routes/application_routes.rb'

namespace :api_auth do
  desc 'Create the initial tables and populate the permissions table'
  task :init, %i[tenant single_role] => [:environment] do |_t, args|
    Apartment::Tenant.switch! args[:tenant] if args[:tenant]

    puts 'Initializing'
    # TODO: before creating the migration make sure to check that there is
    #  no roles tables or permissions tables
    if ActiveRecord::Base.connection.table_exists? 'users'

      if args[:single_role].nil?
        # creating roles table
        sh 'rails g model role name:string description:text'
        Rake::Task['db:migrate'].invoke

        # creating a join table between users and roles
        sh 'rails g migration CreateJoinTableUserRole user role'
        sh 'rails db:migrate'

      else
        sh 'rails g model role name:string description:text user:references'
        sh 'rails db:migrate'
      end

      # creating permissions table
      sh 'rails g model permission controller:string action:string allowed_params:json'
      sh 'rails db:migrate'

      # creating a join table between roles and permissions
      sh 'rails g migration CreateJoinTableRolePermission role permission'
      sh 'rails db:migrate'

    else
      puts 'users table does not exist !'
      next
    end
    puts 'Done !'
  end

  desc 'Populate the permissions table with all the controllers and actions of the application'
  task :create_permissions, %i[tenant] => [:environment] do |_t, args|
    Apartment::Tenant.switch! args[:tenant] if args[:tenant]
    AppRoutes::ApplicationRoutes.new
  end
end
