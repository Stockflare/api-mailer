describe Payload::Email::Payload do
  subject(:payload) { build(:payload_email_payload) }

  it { should respond_to(:Destination) }

  it { should respond_to(:Source) }

  it { should respond_to(:ReplyToAddresses) }

  it { should_not respond_to(:Destination=) }

  it { should_not respond_to(:Source=) }

  it { should_not respond_to(:ReplyToAddresses=) }
end
