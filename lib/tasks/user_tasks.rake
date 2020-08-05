# frozen_string_literal: true

namespace :api_auth do
  desc 'Create a default user and make it superadmin'
  task :create_superadmin, [:tenant] => [:environment] do |_t, args|
    Apartment::Tenant.switch args[:tenant] do
      user = User.find_by_email('giovanni@montedelgallo.com')
      role = Role.find_by_name('superadmin')
      if user
        puts 'User giovanni@montedelgallo.com already exists'
      else
        user = User.create!(email: 'giovanni@montedelgallo.com', password: '123456')
        puts "User created with email: 'giovanni@montedelgallo.com', password: '123456'"
      end
      role ||= Role.create!(name: 'superadmin')
      user.roles << role
    end
    puts '###################################################'
    puts '##'
    puts '##   USER CREATED:'
    puts '##'
    puts '##   email: giovanni@montedelgallo.com'
    puts '##   password: 123456'
    puts "##   tenant: #{args[:tenant]}"
    puts '##'
    puts '###################################################'
  end

  desc 'create custom user'
  task :create_user, %i[tenant email password] => [:environment] do |_t, args|
    Apartment::Tenant.switch args[:tenant] do
      User.create!(email: args[:email], password: args[:password])
      puts '###################################################'
      puts '##'
      puts '##   USER CREATED:'
      puts '##'
      puts "##   email: #{args[:email]}"
      puts "##   password: #{args[:password]}"
      puts "##   tenant: #{args[:tenant]}"
      puts '##'
      puts '###################################################'
    end
  end

  desc 'Reset user password'
  task :reset_password, %i[tenant email new_password] => [:environment] do |_t, args|
    # rails "auth:reset_password[uno, giovanni@montedelgallo.com, password]"
    Apartment::Tenant.switch args[:tenant] do
      user = User.find_by_email(args[:email])
      user.password = args[:new_password]
      user.save
    end

    puts '###################################################'
    puts '##'
    puts '##   USER PASSWORD RESET:'
    puts '##'
    puts "##   email: #{args[:email]}"
    puts "##   password: #{args[:new_password]}"
    puts "##   tenant: #{args[:tenant]}"
    puts '##'
    puts '###################################################'
  end

  desc 'Make a user superadmin'
  task :promote_superadmin, %i[tenant email] => [:environment] do |_t, args|
    # rails "auth:reset_password[uno, giovanni@montedelgallo.com, password]"
    Apartment::Tenant.switch args[:tenant] do
      user = User.find_by_email(args[:email])
      role = Role.find_by_name('superadmin')
      role ||= Role.create!(name: 'superadmin')
      user.roles << role
    end

    puts '###################################################'
    puts '##'
    puts '##   USER PROMOTED TO SUPERADMIN:'
    puts '##'
    puts "##   email: #{args[:email]}"
    puts "##   tenant: #{args[:tenant]}"
    puts '##'
    puts '###################################################'
  end

  desc 'create admin'
  task :create_admin, %i[email password] => [:environment] do |_t, args|
    Admin.create!(email: args[:email], password: args[:password])
    puts '###################################################'
    puts '##'
    puts '##   ADMIN CREATED:'
    puts '##'
    puts "##   email: #{args[:email]}"
    puts "##   password: #{args[:password]}"
    puts '##'
    puts '###################################################'
  end
end
