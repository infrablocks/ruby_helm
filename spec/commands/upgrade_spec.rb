require 'spec_helper'

describe RubyHelm::Commands::Upgrade do
  before(:each) do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyHelm.reset!
  end

  it 'calls the helm upgrade command' do
    command = RubyHelm::Commands::Upgrade.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm upgrade some-release /some/chart', any_args))

    command.execute(
        release: 'some-release',
        chart: '/some/chart'
    )
  end

  it 'calls --set for all the given values' do
    command = RubyHelm::Commands::Upgrade.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm upgrade --set firstKey=firstValue,secondKey=secondValue some-release /some/chart', any_args))

    command.execute(
        release: 'some-release',
        chart: '/some/chart',
        values: {
            firstKey: 'firstValue',
            secondKey: 'secondValue'
        }
    )
  end

  it 'calls --install if install is set to true' do
    command = RubyHelm::Commands::Upgrade.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm upgrade --install some-release /some/chart', any_args))

    command.execute(
        release: 'some-release',
        chart: '/some/chart',
        install: true,
    )
  end
end
