describe Payload::Email::Payload::Destination do
  subject(:destination) { build(:payload_email_payload_destination) }

  it { should respond_to(:BccAddresses) }

  it { should respond_to(:CcAddresses) }

  it { should respond_to(:ToAddresses) }

  it { should_not respond_to(:BccAddresses=) }

  it { should_not respond_to(:CcAddresses=) }

  it { should_not respond_to(:ToAddresses=) }
end
