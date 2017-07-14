FactoryGirl.define do
  factory :feed do
    sequence(:description) { |n| "hello#{n}" }
    sequence(:url) { |n| "bob#{n}www.youtube.com/watch?v=zFt0tO4Op14" }
    sequence(:user_id) {|n| 0 + n}
  end

end
