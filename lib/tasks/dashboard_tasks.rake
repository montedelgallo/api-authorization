# frozen_string_literal: true

namespace :api_auth do
  desc 'Create the dashboard'
  task :install_dashboard, :environment do |_t, args|
    sh 'rails g rails_admin:install auth_dashboard', verbose: false
    sh 'bundle exec bin/api_auth append_config rails_admin "config.included_models = [\"User\", \"Role\", \"Permission\"]"', verbose: false
  end
end
