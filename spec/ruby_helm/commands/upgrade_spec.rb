# frozen_string_literal: true

require 'spec_helper'

describe RubyHelm::Commands::Upgrade do
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

  it 'calls the helm upgrade command' do
    command = described_class.new(binary: 'helm')

    command.execute(
      release: 'some-release',
      chart: '/some/chart'
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('helm upgrade some-release /some/chart'))
  end

  it 'calls --set for all the given values' do
    command = described_class.new(binary: 'helm')

    command.execute(
      release: 'some-release',
      chart: '/some/chart',
      values: {
        firstKey: 'firstValue',
        secondKey: 'secondValue'
      }
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('helm upgrade ' \
             '--set firstKey=firstValue,secondKey=secondValue ' \
             'some-release /some/chart'))
  end

  it 'calls --install if install is set to true' do
    command = described_class.new(binary: 'helm')

    command.execute(
      release: 'some-release',
      chart: '/some/chart',
      install: true
    )

    expect(executor.executions.first.command_line.string)
      .to(eq('helm upgrade --install some-release /some/chart'))
  end
end
