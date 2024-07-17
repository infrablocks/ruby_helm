# frozen_string_literal: true

require 'spec_helper'

describe RubyHelm::Commands::Template do
  let(:executor) { Lino::Executors::Mock.new }

  before do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
    Lino.configure do |config|
      config.executor = executor
    end
  end

  after do
    Lino.reset!
    RubyHelm.reset!
  end

  it 'calls the helm template command' do
    command = described_class.new(binary: 'helm')

    command.execute(chart: '/some/chart')

    expect(executor.executions.first.command_line.string)
      .to(eq('helm template /some/chart'))
  end

  it 'calls --set for all the given values' do
    command = described_class.new(binary: 'helm')

    command.execute(
      chart: '/some/chart',
      values: {
        firstKey: 'firstValue',
        secondKey: 'secondValue'
      }
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('helm template ' \
             '--set firstKey=firstValue,secondKey=secondValue /some/chart'))
  end

  it 'specifies the name of the release' do
    command = described_class.new(binary: 'helm')

    command.execute(
      chart: '/some/chart',
      name: 'some-release'
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('helm template --name some-release /some/chart'))
  end

  it 'specifies the output directory' do
    command = described_class.new(binary: 'helm')

    command.execute(
      chart: '/some/chart',
      output_directory: '/some/output'
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('helm template --output-dir /some/output /some/chart'))
  end
end
