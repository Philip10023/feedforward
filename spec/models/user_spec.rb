require 'rails_helper'
require "shoulda-matchers"
require "factory_girl_rails"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end


describe User, type: :model do
  User.create(
    email: 'JoeShmo@gmail.com',
    username: 'hello',
    password: 'something',
    password_confirmation: 'something',
    username: 'JoeShmo',
    admin: false
    )
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:username) }
end
