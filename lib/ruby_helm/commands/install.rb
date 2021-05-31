# frozen_string_literal: true

require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Install < Base
      # rubocop:disable Metrics/MethodLength
      def configure_command(builder, opts)
        chart = opts[:chart]
        name = opts[:name]
        values = opts[:values] || {}

        paired_values = values.map do |key, value|
          "#{key}=#{value}"
        end

        builder.with_subcommand('install') do |sub|
          unless values.empty?
            sub = sub.with_option(
              '--set',
              paired_values.join(','),
              separator: ' '
            )
          end
          sub = sub.with_option('--name', name, separator: ' ') if name
          sub
        end
               .with_argument(chart)
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
