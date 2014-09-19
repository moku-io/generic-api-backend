# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user_#{n}@test.com"}
    # sequence(:username) {|n| "user_#{n}"}
    password "example"
    password_confirmation "example"
    # sequence(:first_name) {|n| "John #{n}"}
    # sequence(:last_name) {|n| "Doe #{n}"}
  end
end
