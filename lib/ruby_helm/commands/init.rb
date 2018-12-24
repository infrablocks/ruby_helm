require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Init < Base
      def configure_command(builder, opts)
        builder.with_subcommand('init')
      end
    end
  end
end
