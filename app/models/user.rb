class User < ActiveRecord::Base
    has_secure_password #this means that password must exist, acording to active Record password is only validation i have is password thing that beeing protected I can save user without name and email if I have password, doesn't care for email and name I am checking if params are emty
    has_many :pictures
end
