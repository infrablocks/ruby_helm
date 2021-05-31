# frozen_string_literal: true

require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Reset < Base
      def configure_command(builder, _opts)
        builder.with_subcommand('reset')
      end
    end
  end
end
