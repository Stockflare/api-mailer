FactoryGirl.define do
  factory :payload_email_properties, class: Payload::Email::Properties do

    TemplateKey { ('a'..'z').to_a.sample(rand(15..20)).join }

    Data do
      {
        name:Faker::Name.name,
        city: Faker::Address.city,
        company: Faker::Company.name,
        email: Faker::Internet.email
      }
    end

    initialize_with { Payload::Email::Properties.new(attributes) }
  end
end
