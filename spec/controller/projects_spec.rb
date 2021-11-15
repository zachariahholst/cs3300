require "rails_helper"

#ensures controller is working propery, getting the correct index and showing the corect project
RSpec.describe ProjectsController, type: :controller do

  # Add this
  login_user

  let(:valid_attributes) {
      { :title => "Test title!", :description => "This is a test description" }
  }

  let(:valid_session) { {} }

  def index
    @projects = Project.view_permissions(current_user).
  end

  describe "GET #index" do
      it "returns a success response" do
          Project.create! valid_attributes
          get :index, params: {}, session: valid_session

          # Make sure to swap this as well
          expect(response).to be_successful # be_successful expects a HTTP Status code of 200
          # expect(response).to have_http_status(302) # Expects a HTTP Status code of 302
      end
  end

  context "GET #index" do
    it "returns a success response" do
      get :index
      # expect(response.success).to eq(true)
      expect(response).to be_success
    end
  end

  context "GET #show" do
    let!(:project) { Project.create(title: "Test title", description: "Test description") }
    it "returns a success response" do
      get :show, params: { id: project }
      expect(response).to be_success
    end
  end





  describe "Projects" do
      describe "GET projects#index" do
        context "when the user is an admin" do
          it "should list titles of all projects"
        end
        
        context "when the user is not an admin" do
          it "should list titles of users own projects" do
        end
        context "when the user is logged in" do
          it "should render projects#index"
        end
        
        context "when the user is logged out" do
          it "should redirect to the login page"
        end
      end
  end

  describe "GET projects#show" do
    it "should render projects#show template" do
    end
  end

  describe "GET projects#new" do
    it "should render projects#new template" do
    end
  end

  describe "POST projects#create" do
    context "with valid attributes" do
      it "should save the new project in the database"
      it "should redirect to the projects#index page"
    end
  
    context "with invalid attributes" do
      it "should not save the new project in the database"
      it "should render projects#new template"
    end
  end

  describe "GET projects#index" do
    context "when the user is an admin" do
      it "should list titles of all projects" do
        admin = create(:admin)
        projects = create_list(:project, 10, user: admin)
        login_as(admin, scope: :user)
        visit projects_path

        projects.each do |project|
          page.should have_description(project.title)
        end
      end
    end

    context "when the user is not an admin" do
      it "should list titles of users own projects" do
        user = create(:user)
        projects = create_list(:project, 10, user: user)
        login_as(user, scope: :user)
        visit projects_path

        projects.each do |project|
          page.should have_description(project.title)
        end
      end
    end
  end    

  describe "GET projects#show" do
    it "should render projects#show template" do
      user = create(:user)
      project = create(:project, user: user)

      login_as(user, scope: :user)
      visit project_path(project.id)

      page.should have_description(project.title)
      page.should have_description(project.description)
    end
  end

  # GET projects#new
  def new
    @project = Project.new
  end


  # POST projects#create
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project), success: "Project is successfully created."
    else
      render action: :new, error: "Error while creating new project"
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  describe "POST projects#create" do
   it "should create a new project" do
     user = create(:user)
     login_as(user, scope: :user)
     visit new_projects_path

     fill_in "project_title", with: "Ruby on Rails"
     fill_in "project_description", with: "Text about Ruby on Rails"

     expect { click_button "Save" }.to change(Project, :count).by(1)
   end
  end

  def update
    if @project.update(project_params)
      flash[:success] = "Project #{@project.title} is successfully updated."
      redirect_to project_path(@project)
    else
      flash[:error] = "Error while updating project"
      redirect_to project_path(@project)
    end
  end
    
  private
    
  def project_params
    params.require(:project).permit(:title, :description)
  end

  describe "PUT projects#update" do
    it "should update an existing project" do
      user = create(:user)
      login_as(user, scope: :user)
      project = create(:project)
      visit edit_project_path(project)
  
      fill_in "project_title", with: "React"
      fill_in "project_description", with: "Text about React"
  
      click_button "Save"
      expect(project.reload.title).to eq "React"
      expect(project.description).to eq "Text about React"
    end
  end

  def destroy
    authorize @project
    if @project.destroy
      flash[:success] = "Project #{@project.title} removed successfully"
      redirect_to projects_path
    else
      flash[:error] = "Error while removing project!"
      redirect_to project_path(@project)
    end 
  end

  describe "DELETE projects#destroy" do
    it "should delete a project" do
      user = create(:admin)
      project = create(:project, user: user)
      login_as(user, scope: :user)
      visit project_path(project.id)
      page.should have_link("Delete")
      expect { click_link "Delete" }.to change(Project, :count).by(-1)
    end
  end  
end
end
end