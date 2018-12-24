require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Install < Base
      def configure_command(builder, opts)
        directory = opts[:directory]
        values = opts[:values] || {}

        paired_values = values.map do |key, value|
          "#{key}=#{value}"
        end

        builder.with_subcommand('install') do |sub|
          sub = sub.with_option(
              '--set',
              paired_values.join(","),
              separator: ' ') unless values.empty?
          sub
        end
            .with_argument(directory)
      end
    end
  end
end
