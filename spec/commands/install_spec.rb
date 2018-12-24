require 'spec_helper'

describe RubyHelm::Commands::Install do
  before(:each) do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyHelm.reset!
  end

  it 'calls the helm install command' do
    command = RubyHelm::Commands::Install.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm install /some/directory', any_args))

    command.execute(directory: '/some/directory')
  end

  it 'calls --set for all the given values' do
    command = RubyHelm::Commands::Install.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm install --set firstKey=firstValue,secondKey=secondValue /some/directory', any_args))

    command.execute(
        directory: '/some/directory',
        values: {
            firstKey: 'firstValue',
            secondKey: 'secondValue'
        }
    )
  end

  it 'specifies the name of the release' do
    command = RubyHelm::Commands::Install.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm install --name some-name /some/directory', any_args))

    command.execute(
        directory: '/some/directory',
        name: 'some-name'
    )
  end
end
