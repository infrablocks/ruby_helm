# frozen_string_literal: true

require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Upgrade < Base
      # rubocop:disable Metrics/MethodLength
      def configure_command(builder, opts)
        release = opts[:release]
        chart = opts[:chart]
        values = opts[:values] || {}
        should_install = opts[:install]

        paired_values = values.map do |key, value|
          "#{key}=#{value}"
        end

        builder.with_subcommand('upgrade') do |sub|
          unless values.empty?
            sub = sub.with_option(
              '--set',
              paired_values.join(','),
              separator: ' '
            )
          end
          sub = sub.with_flag('--install') if should_install
          sub
        end
               .with_argument(release)
               .with_argument(chart)
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
