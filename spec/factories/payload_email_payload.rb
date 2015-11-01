FactoryGirl.define do
  factory :payload_email_payload, class: Payload::Email::Payload do

    Destination { build(:payload_email_payload_destination) }

    Source { Faker::Internet.email }

    ReplyToAddresses { Array.new(rand(1..5)).collect { |*_| Faker::Internet.email } }

    initialize_with { Payload::Email::Payload.new(attributes) }
  end
end
