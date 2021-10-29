
require "rails_helper"

#visitor should see all projects without access to add, edit and remove features
RSpec.feature "Visiting the homepage", type: :feature do
  scenario "The visitor should see projects" do
    visit root_path
    expect(page).to have_text("Projects")
  end
end
