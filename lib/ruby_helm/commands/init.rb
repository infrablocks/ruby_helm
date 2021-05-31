# frozen_string_literal: true

require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Init < Base
      def configure_command(builder, _opts)
        builder.with_subcommand('init')
      end
    end
  end
end
