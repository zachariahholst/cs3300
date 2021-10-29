require "rails_helper"

RSpec.describe Project, type: :model do
  context "validations tests" do

    #validates a title is present
    it "ensures the title is present" do
      project = Project.new(description: "Content of the description")
      validate_presence_of :title
    end

    #validates a description is present
    it "ensures the description is present" do
        project = Project.new(title: "Some Title")
        validate_presence_of :description
      end
    
    #validates that the project is saved
    it "should be able to save project" do
      project = Project.new(title: "Title", description: "Some description content goes here")
      expect(project.save).to eq(true)
    end
  end

  
  context "scopes tests" do
    let(:params) { { title: "Title", description: "some description" } }
    before(:each) do
      Project.create(params)
      Project.create(params)
      Project.create(params)
    end

    it "should return all projects" do
      expect(Project.count).to eq(3)
    end
  end
end