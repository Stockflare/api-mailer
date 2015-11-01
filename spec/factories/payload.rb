FactoryGirl.define do
  factory :payload, class: Payload do
    
    Configuration { build(:payload_configuration) }

    Email { build(:payload_email) }

    initialize_with { Payload.new(attributes) }
  end
end
