require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations tests" do

    #validates a email is present
    it "ensures the email is present" do
      user = User.new(password: "somepassword")
      validate_presence_of :email
    end
    #validates a password is present
    it "ensures the password is present" do
      user = User.new(email: "somepassword@e.com")
      validate_presence_of :password
    end
    
  end
end
