FactoryGirl.define do
  factory :user do
    name      "Simon Welker"
    email     "simon.welker@esirion.de"
    password  "foobar"
    password_confirmation "foobar"
  end
end