require 'rails_helper'

RSpec.feature "User registers", type: :feature do

  scenario "with valid details" do

    visit new_user_registration_path

    
    expect(current_path).to eq(new_user_registration_path)

    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    fill_in "Password confirmation", with: "test-password"
    click_button "Sign up"

    expect(current_path).to eq root_path
    
    visit new_user_session_path
   

    login_as( User.create(email: "tester@example.tld", password: "test-password"))

    expect(current_path).to eq root_path
    page.find('body').text("Signed in successfully.")
    page.find('body').text("example@email.com")
  end


  context "with invalid details" do

    before do
      visit new_user_registration_path
    end

    scenario "blank fields" do

      expect_fields_to_be_blank

      click_button "Sign up"

      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Password can't be blank"
    end

    scenario "incorrect password confirmation" do

      fill_in "Email", with: "tester@example.tld"
      fill_in "Password", with: "test-password"
      fill_in "Password confirmation", with: "not-test-password"
      click_button "Sign up"

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario "already registered email" do

      create(:user, email: "dave@example.tld")

      fill_in "Email", with: "dave@example.tld"
      fill_in "Password", with: "test-password"
      fill_in "Password confirmation", with: "test-password"
      click_button "Sign up"

      expect(page).to have_content "Email has already been taken"
    end

    scenario "invalid email" do

      fill_in "Email", with: "invalid-email-for-testing"
      fill_in "Password", with: "test-password"
      fill_in "Password confirmation", with: "test-password"
      click_button "Sign up"

      expect(page).to have_content "Email is invalid"
    end

    scenario "too short password" do
      
      min_password_length = 6
      too_short_password = "p" * (min_password_length - 1)
      fill_in "Email", with: "someone@example.tld"
      fill_in "Password", with: too_short_password
      fill_in "Password confirmation", with: too_short_password
      click_button "Sign up"

      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end

  end

  private

  def expect_fields_to_be_blank
    expect(page).to have_field("Email", with: "", type: "email")
    # These password fields don't have value attributes in the generated HTML,
    # so with: syntax doesn't work.
    expect(find_field("Password", type: "password").value).to be_nil
    expect(find_field("Password confirmation", type: "password").value).to be_nil
  end

end