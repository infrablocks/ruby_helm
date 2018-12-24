require 'spec_helper'

describe RubyHelm::Commands::Init do
  before(:each) do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyHelm.reset!
  end

  it 'calls the helm init command' do
    command = RubyHelm::Commands::Init.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm init', any_args))

    command.execute
  end
end