class UsersController < ApplicationController
 
  #render v rederect: access to variables only with render
  #the purpose of this route is to render the login page (form)
  get "/login" do
    redirect_if_logged_in
    erb :"login"
  end
 
  # the purpose of this route is to receive the login form,
  # find the user, and log the user in (create a session)
  post "/login" do
    # params looks like: {email: "user@user.com", password: "password"}
    # Find the user
    @user = User.find_by(email: params[:email])
    # Authenticate the user - verify the user is who they say they are
    # they have the credentials - email/password combo
    if @user && @user.authenticate(params[:password])
      # log the user in - create the user session
      session[:user_id] = @user.id  # actually logging the user in
      # redirect to the user's show page
      #redirect "users/#{@user.id}" - I want to
      # redirect to the pictures index page
      redirect "/pictures" 
    else
       # tell the user they entered invalid credentials
      flash[:errors] = "Your credentials were invalid. Please sign up or try again."
      # redirect them to the login page
      redirect "/login"
    end
  end

  # get sign up route that renders signup form
  get "/signup" do
    #render my sign form
    erb :"signup"
  end
   
  # here is where we will create a new user and persist the new
    # user to the DB
    # params will look like this:
    # {
    #   "name"=>"Elizabeth",
    #   "email"=>"elizabeth@e.com",
    #   "password"=>"password"
    # }
    # I only want to persist a user that has a name, email, AND password
  post "/users" do #with create if I create new user inside if block @user.error will give @user nill)
    @user = User.new(params)# I moved User.create abov if block and put User.new
    #if params[:name] != "" && params[:email] != "" && params[:password] != "" #when I put new and validation in model I dont need this
    # I now have ActiveRecord Validations within my user model class, rather
    # than just checking for params keys to have values.  Either way works fine,
    # and checking params is fine for this project.  AR validations give us
    # a little more functionality if we want it.
    if @user.save
    # valid input  
    session[:user_id] = @user.id # actually logging the user in
    # where do I go now?
    # let's go to the user show page
    flash[:message] = "You have successfully created an account, #{@user.name}! Welcome!"
    redirect "/users/#{@user.id}"
   else
    # not valid input
    # it would be better to include a message to the user
    # telling them what is wrong
    flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}" #will puts in string format rather then array format 
    #flash is part of active record and is used to communicate with user, errors get populated after certain method invocation
    #flash messiges only work if controller action ends with rederect becouse they sends new HTTP request where flash messiges live and they last only one rquest, new refresh of page they are lost
    redirect '/signup'
   end
  end
  #create save and update will trigger the validation


   # user SHOW route
  get "/users/:id" do
    # what do I need to do first?
    @user = User.find_by(id: params[:id])
    @pictures = @user.pictures 
    redirect_if_not_logged_in
    erb :"/users/show.html"
  end

  
  get '/my_pictures' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      redirect_if_not_logged_in
    end
  end 

  get '/logout' do
    session.clear
    redirect '/'
  end
end
