FactoryGirl.define do
  factory :payload_email, class: Payload::Email do

    Properties { build(:payload_email_properties) }

    Payload { build(:payload_email_payload) }

    initialize_with { Payload::Email.new(attributes) }
  end
end
