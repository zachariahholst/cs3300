
require 'rails_helper'

RSpec.feature "Projects", type: :feature do



  context "Create new project" do
    before(:each) do
      user = FactoryBot.build(:user)
      login_as(user)
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    #succesful creation if title and description present
    scenario "should be successful" do
      user = FactoryBot.build(:user)
      login_as(user)
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    #unsuccesful if description is blank
    scenario "should fail" do
      user = FactoryBot.build(:user)
      login_as(user)
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
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
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end