# frozen_string_literal: true

require 'spec_helper'

describe RubyHelm::Commands::Reset do
  before do
    RubyHelm.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyHelm.reset!
  end

  it 'calls the helm reset command' do
    command = described_class.new(binary: 'helm')

    allow(Open4).to(receive(:spawn))

    command.execute

    expect(Open4).to(
      have_received(:spawn)
          .with('helm reset', any_args)
    )
  end
end
