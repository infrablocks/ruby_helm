# frozen_string_literal: true

require 'ruby_helm/version'
require 'ruby_helm/commands'

module RubyHelm
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset!
      @configuration = nil
    end
  end

  module ClassMethods
    def clean(opts = {})
      Commands::Clean.new.execute(opts)
    end
  end

  extend ClassMethods

  def self.included(other)
    other.extend(ClassMethods)
  end

  class Configuration
    attr_accessor :binary

    def initialize
      @binary = 'helm'
    end
  end
end
