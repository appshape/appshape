FactoryGirl.define do
  factory :personal_organization, class: Organization::PersonalOrganization do
    name Faker::Company.name
    owner {create(:user)}
  end
end
