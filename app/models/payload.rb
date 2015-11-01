class Payload
  include ValueObject

  class Configuration
    include ValueObject

    values do
      attribute :Bucket, String, default: Mailer::BUCKET
    end
  end

  class Email
    include ValueObject

    class Properties
      include ValueObject

      values do
        attribute :TemplateKey, String
        attribute :Data, Hash, default: {}
      end
    end

    class Payload
      include ValueObject

      class Destination
        include ValueObject

        values do
          attribute :BccAddresses, Array[String], default: []
          attribute :CcAddresses, Array[String], default: []
          attribute :ToAddresses, Array[String]
        end
      end

      values do
        attribute :Destination, Destination
        attribute :Source, String, default: Mailer::FROM
        attribute :ReplyToAddresses, Array[String], default: [Mailer::FROM]
      end
    end

    values do
      attribute :Properties, Properties
      attribute :Payload, Payload
    end
  end

  values do
    attribute :Configuration, Configuration
    attribute :Email, Email
  end

  def self.from_params(params)
    new to_payload(params)
  end

  private

  def self.to_payload(params)
    {
      Email: {
        Properties: {
          TemplateKey: params[:template],
          Data: params[:data]
        },
        Payload: {
          Destination: {
            ToAddresses: [params[:recipient]]
          }
        }
      }
    }
  end
end
