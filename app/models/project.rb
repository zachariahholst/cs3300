class Project < ApplicationRecord
    #requires a title and description
    validates_presence_of :title, :description

    def self.view_permissions(current_user)
        current_user.role.admin? ? Projects.all : current_user.stories
    end
end
