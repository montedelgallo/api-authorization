# frozen_string_literal: true

require 'thor'
require 'api_authorization'
module ApiAuthorization
  class Cli < Thor
    include Thor::Actions

    def self.exit_on_failure?
      true
    end

    def self.source_root
      File.dirname(__FILE__)
    end

    desc 'test', 'just a test command'
    def test
      puts 'If you see this message thor cli is working !'
    end

    desc 'append_has_and_belongs_to_many', 'append has_and_belongs_to_many'
    def append_has_and_belongs_to_many(model_filename, belongs_to)
      inject_into_file "./app/models/#{model_filename}.rb", "  has_and_belongs_to_many :#{belongs_to}\n", before: /^end/
    end

    desc 'append_config', 'insert config code'
    def append_config(config_file, config_code)
      inject_into_file "./config/initializers/#{config_file}.rb", "  #{config_code}\n", before: /^end/
    end
  end
end
