# frozen_string_literal: true

require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Template < Base
      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def configure_command(builder, opts)
        chart = opts[:chart]
        name = opts[:name]
        output_directory = opts[:output_directory]
        values = opts[:values] || {}

        paired_values = values.map do |key, value|
          "#{key}=#{value}"
        end

        builder.with_subcommand('template') do |sub|
          unless values.empty?
            sub = sub.with_option(
              '--set',
              paired_values.join(','),
              separator: ' '
            )
          end
          sub = sub.with_option('--name', name, separator: ' ') if name
          if output_directory
            sub = sub.with_option(
              '--output-dir',
              output_directory,
              separator: ' '
            )
          end
          sub
        end
               .with_argument(chart)
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize
    end
  end
end
