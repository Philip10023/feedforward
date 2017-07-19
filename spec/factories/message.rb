FactoryGirl.define do
  factory :message do
    sequence(:body) { |n| "hello#{n}chatroom" }
    sequence(:user_id) {|n| 0 + n}
  end

end
