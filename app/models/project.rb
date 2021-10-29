class Project < ApplicationRecord
    #requires a tittle and description
    validates_presence_of :title, :description
end
