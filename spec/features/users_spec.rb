require 'rails_helper'

RSpec.feature "User", type: :feature do

    context "Create new account" do
        before(:each) do
          visit new_user_registration_path
        end
    
        #succesfully created with username and password
        scenario "should be succesful" do
          User.create(email: "example@email.com", password: "password")
          click_link "Sign Up"
          page.find('body').text("example@email.com")
          expect(User.count).to eq(1)
        end
        
        #password left blank
        scenario "should be unsuccesful" do
          fill_in "Email", with: "example@email.com"
          click_link "Sign Up"
          page.find('body').text("Password can't be blank")
        end
        #username left blank
        scenario "should be unsuccesful" do
          fill_in "Password", with: "password"
          click_link "Sign Up"
          page.find('body').text("Email can't be blank")
        end
      end
end







