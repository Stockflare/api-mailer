describe Token do
  include_context 'dynamo' do
    let(:table_name) { Table::TOKEN }

    let(:table) { build(:token_table) }
  end

  subject(:token) { build(:token) }

  it { should respond_to(:username) }

  it { should respond_to(:token) }

  it { should respond_to(:expires_at) }

  it { should_not respond_to(:expires_at=) }

  it { should_not respond_to(:username=) }

  it { should_not respond_to(:token=) }
end
