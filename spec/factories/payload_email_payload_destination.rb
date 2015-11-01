FactoryGirl.define do
  factory :payload_email_payload_destination, class: Payload::Email::Payload::Destination do

    BccAddresses { Array.new(rand(1..5)).collect { |*_| Faker::Internet.email } }

    CcAddresses { Array.new(rand(1..5)).collect { |*_| Faker::Internet.email } }

    ToAddresses { Array.new(rand(1..5)).collect { |*_| Faker::Internet.email } }

    initialize_with { Payload::Email::Payload::Destination.new(attributes) }
  end
end
