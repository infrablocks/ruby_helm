require 'lino'
require_relative 'base'

module RubyHelm
  module Commands
    class Template < Base
      def configure_command(builder, opts)
        chart = opts[:chart]
        name = opts[:name]
        output_directory = opts[:output_directory]
        values = opts[:values] || {}

        paired_values = values.map do |key, value|
          "#{key}=#{value}"
        end

        builder.with_subcommand('template') do |sub|
          sub = sub.with_option(
              '--set',
              paired_values.join(","),
              separator: ' ') unless values.empty?
          sub = sub.with_option('--name', name, separator: ' ') if name
          sub = sub.with_option(
              '--output-dir',
              output_directory,
              separator: ' '
          ) if output_directory
          sub
        end
            .with_argument(chart)
      end
    end
  end
end
