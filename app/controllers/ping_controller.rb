class PingController < Grape::API
  format :json
  get { { ping: 'pong' } }
end
