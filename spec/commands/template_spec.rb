require 'spec_helper'

describe RubyHelm::Commands::Template do
  before(:each) do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyHelm.reset!
  end

  it 'calls the helm template command' do
    command = RubyHelm::Commands::Template.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm template /some/chart', any_args))

    command.execute(chart: '/some/chart')
  end

  it 'calls --set for all the given values' do
    command = RubyHelm::Commands::Template.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm template --set firstKey=firstValue,secondKey=secondValue /some/chart', any_args))

    command.execute(
        chart: '/some/chart',
        values: {
            firstKey: 'firstValue',
            secondKey: 'secondValue'
        }
    )
  end

  it 'specifies the name of the release' do
    command = RubyHelm::Commands::Template.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm template --name some-release /some/chart', any_args))

    command.execute(
        chart: '/some/chart',
        name: 'some-release'
    )
  end

  it 'specifies the output directory' do
    command = RubyHelm::Commands::Template.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm template --output-dir /some/output /some/chart', any_args))

    command.execute(
        chart: '/some/chart',
        output_directory: '/some/output'
    )
  end
end
