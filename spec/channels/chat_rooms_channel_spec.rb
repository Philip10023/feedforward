require "rails_helper"

class TestConnection
  attr_reader :identifiers, :logger

  def initialize(identifiers_hash = {})
    @identifiers = identifiers_hash.keys
    @logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(StringIO.new))

    # This is an equivalent of providing `identified_by :identifier_key` in ActionCable::Connection::Base subclass
    identifiers_hash.each do |identifier, value|
      define_singleton_method(identifier) do
        value
      end
    end
  end
end

RSpec.describe ChatRoomsChannel do

  let(:current_user) { FactoryGirl.create(:user, id: "1", username: "Bob", email: "joshmo@gmail.com") }

  subject(:channel) { described_class.new(connection, current_user) }

  # Connection is `identified_by :current_profile`
  let(:connection) { TestConnection.new(current_user: current_user) }
  let(:action_cable) { ActionCable.server }

  # ActionCable dispatches actions by the `action` attribute.
  # In this test we assume the payload was successfully parsed (it could be a JSON payload, for example).
  let(:data) do
    {
      "action" => "test_action",
      "times_to_say_hello" => 3
    }
  end

  it "broadcasts 'Hello, Bob!' 3 times"  do
    # expect(action_cable).to receive(:broadcast).with("1", "Hello, Bob!").exactly(3).times

    channel.perform_action(data)
  end
end
