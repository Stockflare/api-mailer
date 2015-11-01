FactoryGirl.define do
  factory :payload_configuration, class: Payload::Configuration do

    Bucket { ('a'..'z').to_a.sample(rand(15..20)).join }

    initialize_with { Payload::Configuration.new(attributes) }
  end
end
