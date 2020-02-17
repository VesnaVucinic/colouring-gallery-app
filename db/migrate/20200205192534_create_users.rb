class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest #in order to encrypt password, I am using bcrypt in my gemfile
      #this is column where are be encrypted password once it has encrypted, 
      #right away I need in my user model to all macro has_secure_password

      t.timestamps null: false #automatically gives me time stamps any time I create or update my model 
    end
  end
end

#rake is the way that we could use command line to run commands and run rugy codes 
#1. rake db:create_migration NAME=create_users_table (NAME=create_users_table  i pass parametars to create table)
#2.in migrate folder i got file create users table with class of same name that inherits from AR migration and I get method change where i will bilt table
#with create_table that takes as argument :users as symbol 
#I open up block  and call mor methods on t object that are going to describe columns I will add to table
