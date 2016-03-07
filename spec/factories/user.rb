FactoryGirl.define do
  factory :user do
    type nil
    uid { rand(1000) }
  end
end