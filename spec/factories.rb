FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "panda@pop#{n}.com" }
    username "pandapop"
    password "cutepandas"
    password_confirmation "cutepandas"
  end

end
