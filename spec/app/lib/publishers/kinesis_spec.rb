describe Publishers::Kinesis do
    let(:payload) { build(:payload) }

    subject(:publisher) { Publishers::Kinesis.new(payloads: [payload]) }

    it { should respond_to(:stream) }

    it { should respond_to(:partition) }

    it { should respond_to(:payloads) }

    it { should respond_to(:push_all) }

    it { should respond_to(:push) }

    it { should respond_to(:blob) }

    specify { expect(subject.stream).to eq Mailer::STREAM }

    specify { expect(subject.partition).to eq 1 }

    specify { expect(subject.payloads).to_not be_empty }

    specify { expect(subject.payloads.sample).to eq payload }

    describe 'return value of #blob' do
      subject { publisher.blob(payload) }

      it { should be_a String }

      it { should eq MultiJson.dump(payload) }
    end
  end
