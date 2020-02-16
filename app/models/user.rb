class User < ActiveRecord::Base
    has_secure_password #this means that password must exist, acording to active Record password is only validation i have is password thing that beeing protected I can save user without name and email if I have password, doesn't care for email and name I am checking if params are emty
    #to add more validation to model in active record
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true #no two users can have same email
    #now I have in active record validation that will prevent create, update, or save in db if this requrements are not met. Preveouslu I checked that params are not empty.
    has_many :pictures
end

# I made sure my app validates user input. I included has_secure_password method in user model which will authenticate against a Bcrypt password.
# I used the active record helper method “presence” to ensure the specified attributes are not empty.

##Define your User class to inherit from ActiveRecord::Base
# tell the `User` class that each user object can have many pictures. We will use the `has_many` macro to do it 
#AR macros (or methods): has_many, belongs_to. They helped us associate user, pictures, 
#The macros we implemented in our classes allow us to associate a picture object directly to an user object:
#The User class has gained a whole bunch of new methods via its inheritance relationship to ActiveRecord
#https://guides.rubyonrails.org/active_record_basics.html#creating-active-record-models