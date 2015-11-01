FactoryGirl.define do
  factory :request, class: Hash do

    template { ('a'..'z').to_a.sample(rand(15..20)).join }

    recipient { Faker::Internet.email }

    data do
      {
        name:Faker::Name.name,
        city: Faker::Address.city,
        company: Faker::Company.name,
        email: Faker::Internet.email
      }
    end

    initialize_with { attributes }
  end
end
