FactoryGirl.define do
  factory :identity do
    user { create(:user, :confirmed) }
    provider 'github'
    uid { Devise.friendly_token(20) }
  end
end