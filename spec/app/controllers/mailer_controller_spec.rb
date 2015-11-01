describe MailerController do
  let(:request) { build(:request) }

  subject { response }

  describe 'POST: /' do
    let(:root) { '/' }

    before { post root, request.to_h }

    specify { expect_status 201 }

    describe 'when a required parameter is missing' do
      [:template, :recipient].each do |key|
        describe "missing :#{key}" do
          let(:payload) do
            payload = request.to_h
            payload.delete(key)
            payload
          end

          before { post root, payload }

          specify { expect_status 400 }
        end
      end
    end
  end
end
