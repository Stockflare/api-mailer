describe Payload::Email do
  subject(:email) { build(:payload_email) }

  it { should respond_to(:Properties) }

  it { should respond_to(:Payload) }

  it { should_not respond_to(:Properties=) }

  it { should_not respond_to(:Payload=) }
end
