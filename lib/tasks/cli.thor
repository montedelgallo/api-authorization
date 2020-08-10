#!/usr/bin/env ruby

# frozen_string_literal: true

require 'thor'
class CLI < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc 'test', 'this is just a test'
  def test
    puts 'Just a test task'
  end

  desc 'append_has_and_belongs_to_many', 'append has_and_belongs_to_many'
  def append_has_and_belongs_to_many(model_filename, belongs_to)
    inject_into_file "./app/models/#{model_filename}.rb", "  has_and_belongs_to_many :#{belongs_to}\n", before: /^end/
  end
end
