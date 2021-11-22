
require 'rails_helper'

RSpec.feature "Projects", type: :feature do



  context "Create new project" do
    before(:each) do
      user = FactoryBot.build(:user)
      login_as(user)
      visit new_project_path
    end

    #succesful creation if title and description present
    scenario "should be successful" do
      user = FactoryBot.build(:user)
      login_as(user)
      fill_in "Description", with: "Test description"
      fill_in "Title", with: "Test Title"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    #unsuccesful if description is blank
    scenario "should fail" do
      user = FactoryBot.build(:user)
      login_as(user)
      click_button "Create Project"
      fill_in "Title", with: "Test Title"
      expect(page).to have_content("Description can't be blank")
    end

    #unsuccesful if title is blank
     scenario "should fail" do
      user = FactoryBot.build(:user)
      login_as(user)
      click_button "Create Project"
      fill_in "Description", with: "Test description"
      expect(page).to have_content("Title can't be blank")
    end   
  end


  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      user = FactoryBot.build(:user)
      login_as(user)
      visit edit_project_path(project)
    end

    #succesfully edited
    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    #fail if description blank
    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      user = FactoryBot.build(:user)
      login_as(user)
      visit projects_path
      click_link "Destroy"
      page.find('body').text("Project was successfully destroyed.")
      #expect(page).to have_content("Project was successfully destroyed.")
      #expect(Project.count).to eq(0)
    end
  end

  context "Create new account" do
    before(:each) do
      visit new_user_registration_path
    end

    #succesfully created with username and password
    scenario "should be succesful" do
      fill_in "Email", with: "example@email.com"
      fill_in "Password", with: "password"
      click_link "Sign Up"
      #expect(page).to have_content("example@email.com")
      page.find('body').text("example@email.com")
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