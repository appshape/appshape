FactoryGirl.define do
  factory :user do
    name  { Faker::Name.name }
    sequence(:email) { |n| Faker::Internet.email("email_#{n}") }
    password { Devise.friendly_token(20) }
    password_confirmation { password }

    trait :confirmed do
      before(:create) { |user| user.skip_confirmation! }
    end
  end
end