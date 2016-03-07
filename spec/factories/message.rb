FactoryGirl.define do
  factory :message do
    message 'some_message'
    image File.new(Rails.root.join('app', 'assets', 'images', 'default.jpg'))
  end
end
