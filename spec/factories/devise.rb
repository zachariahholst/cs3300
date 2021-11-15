FactoryBot.define do
    factory :user do
      id {1}
      email {"test@user.com"}
      password {"qwerty"}
      # Add additio
    end
      
    factory :project do
      user
      sequence(:title) { |n| "Title#{n}" }
      sequence(:description) { |n| "Description#{n}" }
    end
  
    #Not used in this tutorial, but left to show an example of different user types
    factory :admin do
      id {2}
      email {"test@admin.com"}
      password {"qwerty"}
      admin {true}
    end
  end