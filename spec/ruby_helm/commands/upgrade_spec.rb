# frozen_string_literal: true

require 'spec_helper'

describe RubyHelm::Commands::Upgrade do
  before do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyHelm.reset!
  end

  it 'calls the helm upgrade command' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute(
      release: 'some-release',
      chart: '/some/chart'
    )

    expect(Open4).to(
      have_received(:spawn)
        .with('helm upgrade some-release /some/chart', any_args)
    )
  end

  it 'calls --set for all the given values' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute(
      release: 'some-release',
      chart: '/some/chart',
      values: {
        firstKey: 'firstValue',
        secondKey: 'secondValue'
      }
    )

    expect(Open4).to(
      have_received(:spawn)
        .with(
          'helm upgrade ' \
          '--set firstKey=firstValue,secondKey=secondValue ' \
          'some-release /some/chart',
          any_args
        )
    )
  end

  it 'calls --install if install is set to true' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute(
      release: 'some-release',
      chart: '/some/chart',
      install: true
    )

    expect(Open4).to(
      have_received(:spawn)
        .with('helm upgrade --install some-release /some/chart', any_args)
    )
  end
end
