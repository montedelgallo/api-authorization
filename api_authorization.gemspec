# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'api_authorization/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'api_authorization'
  spec.version     = ApiAuthorization::VERSION
  spec.authors     = ['Giovanni Panasiti', 'Azdren Ymeri']
  spec.email       = ['giovanni@montedelgallo.com', 'azdren.ymeri@montedelgallo.com']
  spec.homepage    = 'https://montedelgallo.com/'
  spec.summary     = 'A multi role bassed authorization'
  spec.description = 'Highly flexible authorization where a user can have more than 1 role with differen permissions.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org/"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.executables = ['api_auth']

  # spec.add_dependency 'activesupport'
  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.2'
  # spec.add_dependency 'rake', '~> 13.0', '>= 13.0.1'
  spec.add_development_dependency 'sqlite3'
  spec.add_dependency 'byebug'
end
