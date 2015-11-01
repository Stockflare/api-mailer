module Publishers
  class Kinesis
    include ValueObject

    values do
      attribute :stream, String, default: Mailer::STREAM

      attribute :partition, Integer, default: 1

      attribute :payloads, Array
    end

    def push_all
      with_kinesis do |kinesis|
        payloads.collect! { |data| { data: blob(data), partition_key: key } }
        kinesis.put_records(stream_name: stream, records: payloads)
      end
    end

    def push(payload)
      with_kinesis do |kinesis|
        kinesis.put_record(stream_name: stream, data: blob(payload), partition_key: key)
      end
    end

    def blob(data)
      MultiJson.dump(data.to_h)
    end

    private

    def with_kinesis(&block)
      block.call kinesis
    end

    def key
      "partitionKey-#{partition}"
    end

    def kinesis
      @kinesis ||= Aws::Kinesis::Client.new
    end
  end
end
