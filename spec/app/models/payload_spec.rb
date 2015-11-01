describe Payload do
  subject(:payload) { build(:payload) }

  it { should respond_to(:Configuration) }

  it { should respond_to(:Email) }

  it { should_not respond_to(:Configuration=) }

  it { should_not respond_to(:Email=) }
end
