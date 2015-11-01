describe Payload::Configuration do
  subject(:configuration) { build(:payload_configuration) }

  it { should respond_to(:Bucket) }

  it { should_not respond_to(:Bucket=) }
end
