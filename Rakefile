ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake' #rake -T methods all come from sinatra/activerecord/rake including rake db:rake migrate

#rake is the way that we could use command line to run commands and run rugy codes 
#1. rake db:create_migration NAME=create_users_table (NAME=create_users_table  i pass parametars to create table)
#2.in migrate folder i got file create users table with class of same name that inherits from AR migration and I get method change where i will bilt table
#with create_table that takes as argument :users as symbol 
#I open up block  and call mor methods on t object that are going to describe columns I will add to table
