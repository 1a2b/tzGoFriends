FactoryGirl.define do
  factory :admin do
    type 'Admin'
    uid { rand(1000) }
  end
end
