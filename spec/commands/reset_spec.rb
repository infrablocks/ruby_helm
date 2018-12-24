require 'spec_helper'

describe RubyHelm::Commands::Reset do
  before(:each) do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after(:each) do
    RubyHelm.reset!
  end

  it 'calls the helm reset command' do
    command = RubyHelm::Commands::Reset.new(binary: 'helm')

    expect(Open4).to(
        receive(:spawn)
            .with('helm reset', any_args))

    command.execute
  end
end