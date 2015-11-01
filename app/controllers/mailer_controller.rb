# Provider of HTTP Endpoints for the Mailer API. This Controller
# is responsible for processing mailer requests sent via HTTP
class MailerController < Grape::API
  default_format :json

  # @!parse include OrmHelper
  helpers OrmHelper

  helpers do
    def payload
      @payload ||= Payload.from_params(params)
    end
  end

  params do
    requires :template, type: String, allow_blank: false
    requires :recipient, type: String, allow_blank: false
    optional :data, type: Hash, default: {}
  end
  post do
    begin
      Publishers.publish([payload])
      status 201
    rescue
      status 400
    end
  end
end
