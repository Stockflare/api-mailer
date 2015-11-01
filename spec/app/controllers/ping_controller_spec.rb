describe PingController do
  before { get '/ping' }

  subject { response }

  specify { expect(json_body).to eq({ ping: 'pong' }) }

  specify { expect_status 200 }
end
