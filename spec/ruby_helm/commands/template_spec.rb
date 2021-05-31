# frozen_string_literal: true

require 'spec_helper'

describe RubyHelm::Commands::Template do
  before do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyHelm.reset!
  end

  it 'calls the helm template command' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute(chart: '/some/chart')

    expect(Open4).to(
      have_received(:spawn)
        .with('helm template /some/chart', any_args)
    )
  end

  it 'calls --set for all the given values' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute(
      chart: '/some/chart',
      values: {
        firstKey: 'firstValue',
        secondKey: 'secondValue'
      }
    )

    expect(Open4).to(
      have_received(:spawn)
        .with(
          'helm template ' \
          '--set firstKey=firstValue,secondKey=secondValue /some/chart',
          any_args
        )
    )
  end

  it 'specifies the name of the release' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute(
      chart: '/some/chart',
      name: 'some-release'
    )

    expect(Open4).to(
      have_received(:spawn)
        .with('helm template --name some-release /some/chart', any_args)
    )
  end

  it 'specifies the output directory' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute(
      chart: '/some/chart',
      output_directory: '/some/output'
    )

    expect(Open4).to(
      have_received(:spawn)
        .with('helm template --output-dir /some/output /some/chart', any_args)
    )
  end
end
