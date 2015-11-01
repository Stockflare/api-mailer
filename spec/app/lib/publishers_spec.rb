describe Publishers do
  it { should respond_to(:<<) }

  it { should respond_to(:current) }

  it { should respond_to(:all) }

  it { should respond_to(:publish) }

  it { should respond_to(:call) }

  describe 'return value of #all' do
    subject { Publishers.all }

    it { should be_a Array }

    it { should_not be_empty }

    it { should include *Publishers.constants.collect(&:downcase) }
  end

  describe 'return value of #call' do
    let(:symbol) { Publishers.constants.collect(&:downcase).sample }

    subject { Publishers.call(symbol) }

    it { should be_a Class }
  end

  describe 'when #publish is called' do
    class TestPublisher
      def initialize(hash)
        @hash = hash
      end
      def push_all
      end
    end

    let(:payload) { { a: 1 } }

    before { Publishers << TestPublisher }

    specify { expect_any_instance_of(TestPublisher).to receive(:push_all) }

    after { Publishers.publish([payload]) }
  end
end
