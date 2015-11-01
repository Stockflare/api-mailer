describe Payload do
  subject(:payload) { build(:payload) }

  it { should respond_to(:Configuration) }

  it { should respond_to(:Email) }

  it { should_not respond_to(:Configuration=) }

  it { should_not respond_to(:Email=) }

  describe 'return value of #to_h' do
    subject { payload.to_h }

    specify { puts Publishers::Kinesis.new(payloads: payload).blob(payload) subject }

    specify { puts MultiJSON.dump subject }
  end
end
