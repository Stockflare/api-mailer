module Publishers
  autoload :Standard, 'publishers/standard'
  autoload :Kinesis, 'publishers/kinesis'

  class << self
    attr_accessor :current
  end

  def self.publish(payload = [])
    current.new(payload).push_all
  end

  def self.<<(pub)
    @current = pub
  end

  def self.all
    constants.collect { |c| c.downcase }
  end

  def self.call(pub)
    const_get(pub.to_s.capitalize.to_sym)
  end
end
