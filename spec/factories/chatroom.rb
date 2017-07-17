FactoryGirl.define do
  factory :chatroom do
    sequence(:title) { |n| "hello#{n}chatroom" }
    sequence(:user_id) {|n| 0 + n}
  end

end
