FactoryGirl.define do
  factory :organization, class: Organization do
    name 'Fighters'
    owner {create(:user)}
  end
end
