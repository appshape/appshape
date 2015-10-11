FactoryGirl.define do
  factory :organization, class: Organization do
    name Faker::Company.name
  end
end
