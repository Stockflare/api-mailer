module Publishers
  class Standard
    include ValueObject

    values do
      attribute :payloads, Array
    end

    def push_all
      payloads.each(&method(:push))
    end

    def push(payload)
      puts payload.inspect
    end
  end
end
