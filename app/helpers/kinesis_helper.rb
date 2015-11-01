module KinesisHelper
  def payload
    @payload ||= Payload.from_params(params)
  end

  def publish!(obj = payload)
    Publishers.publish([payload])
  end
end
