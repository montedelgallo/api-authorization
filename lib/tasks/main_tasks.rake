# frozen_string_literal: true

require_relative './../app_routes/application_routes.rb'

namespace :api_auth do
  desc 'Create the initial tables'
  task :install, %i[tenant single_role] => [:environment] do |_t, args|
    Apartment::Tenant.switch! args[:tenant] if args[:tenant]

    puts 'Initializing'
    # TODO: before creating the migration make sure to check that there is
    #  no roles tables or permissions tables
    if ActiveRecord::Base.connection.table_exists? 'users'

      if args[:single_role].nil?
        # creating roles table
        # sh 'rails g model role name:string description:text', verbose: false
        # sh 'rails db:migrate', verbose: false

        # giving permissions
        sh 'chmod a+x ./../../bin/thor_tasks'
        # adding has_many_and_belongs_to with thor
        sh './../../bin/thor_tasks append_has_and_belongs_to_many role users', verbose: false
        sh './../../bin/thor_tasks append_has_and_belongs_to_many user roles', verbose: false

        # creating a join table between users and roles
        sh 'rails g migration CreateJoinTableUserRole user role', verbose: false
        sh 'rails db:migrate', verbose: false

      else
        sh 'rails g model role name:string description:text user:references', verbose: false
        sh 'rails db:migrate', verbose: false
      end

      # creating permissions table
      sh 'rails g model permission controller:string action:string allowed_params:json', verbose: false
      sh 'rails db:migrate', verbose: false

      sh './../../bin/thor_tasks append_has_and_belongs_to_many role permissions', verbose: false
      sh './../../bin/thor_tasks append_has_and_belongs_to_many permission roles', verbose: false

      # creating a join table between roles and permissions
      sh 'rails g migration CreateJoinTableRolePermission role permission', verbose: false
      sh 'rails db:migrate', verbose: false

    else
      puts 'users table does not exist !'
      next
    end
    puts 'Done !'
  end

  desc 'Populate the permissions table with all the controllers and actions of the application'
  task :re_populate_permissions, %i[tenant] => [:environment] do |_t, args|
    Apartment::Tenant.switch! args[:tenant] if args[:tenant]
    AppRoutes::ApplicationRoutes.new
  end
end
