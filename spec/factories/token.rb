FactoryGirl.define do
  factory :token, class: Token do
    username { Faker::Internet.email }

    initialize_with { Token.new(attributes) }
  end
end
