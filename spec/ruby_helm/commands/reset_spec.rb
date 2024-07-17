# frozen_string_literal: true

require 'spec_helper'

describe RubyHelm::Commands::Reset do
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

  it 'calls the helm reset command' do
    command = described_class.new(binary: 'helm')

    command.execute

    expect(executor.executions.first.command_line.string)
      .to(eq('helm reset'))
  end
end
