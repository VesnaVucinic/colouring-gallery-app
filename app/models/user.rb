class User < ActiveRecord::Base
    has_secure_password #this means that password must exist, acording to active Record password is only validation i have is password thing that beeing protected I can save user without name and email if I have password, doesn't care for email and name I am checking if params are emty
    #to add more validation to model in active record
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true #no two users can have same email
    #now I have in active record validation that will prevent create, update, or save in db if this requrements are not met. Preveouslu I checked that params are not empty.
    has_many :pictures
end
