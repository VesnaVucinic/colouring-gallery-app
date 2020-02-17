class UsersController < ApplicationController #inherit every method from application controler as helpper methods
 
  #render v rederect: access to variables only with render
  #the purpose of this route is to render the login page (form)
  get "/login" do
    redirect_if_logged_in
    erb :"login"
  end

 #with this route we create something new but not in db but WE ARE CREATIN SESSION WITH THIS ROUT which means we adding key value pair to the session hash
  # the purpose of this route is to receive the login form, find the user, and log the user in (create a session)
  post "/login" do #(method in a form coresponds with Sinatra method post  we are invoking,sinatra named methods after HTTP verbs and HTTP verbs are also known as methods in form)
    # params looks like: {email: "user@user.com", password: "password"}
    # Find the user
    #find _by method takes as argument key-value pair; find can't go with email becouse find method as argument takes integer
    #find will result in a error.  the find_by method simply returns nil if a record is not found.
    #if I pass just (params[:email]) without key it will return first value in db 
    @user = User.find_by(email: params[:email])
    # Authenticate the user - verify the user is who they say they are, make sure they are in db
    # they have the credentials - email/password combo
    # undefined method authenticate for nill class means that user has value nill, user doesn't exist in db, and nill class doesn't have authenticate nethod
    if @user && @user.authenticate(params[:password])#call authenticate method on the user and as argument take password thet is in params
      #authenticate return folse for wrong password or whole isntance of user is password is ok vesna.authenticate("vesnica")=>instance of vesna, user itself which is a truthy value
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

   #post usually create something new
  # here is where we will create a new user and persist the new user to the db
    # params will look like this:
    # {
    #   "name"=>"Elizabeth",
    #   "email"=>"elizabeth@e.com",
    #   "password"=>"password"
    # }
    # I only want to persist a user that has a name, email, AND password
  post "/users" do #with create if I create new user inside if block @user.error will give @user nill)
    #use massasigment to create new user
    @user = User.new(params)# I moved User.create abov if block and put User.new
    #if params[:name] != "" && params[:email] != "" && params[:password] != "" #when I put new and validation in model I dont need this
    # I now have ActiveRecord Validations within my user model class, rather
    # than just checking for params keys to have values.  Either way works fine,
    # and checking params is fine for this project.  AR validations give us
    # a little more functionality if we want it.
    if @user.save
    # valid input  
    session[:user_id] = @user.id # when user sign up I want to log him in righ away, not to send him to log in page to put his new created credentials again 
    # where do I go now?
    # let's go to the user show page
    flash[:message] = "You have successfully created an account, #{@user.name}! Welcome!"
    redirect "/pictures" #redirect "/users/#{@user.id}" redirect will send brend new get request to get users id 
     #job of this rout is to create new user not to show new user  and that is redirect is better choise then erb :'/users/show'. once is created new user it will send as to route thet will show new user abd that is get '/users/:id'
   else
    # not valid input
    # it would be better to include a message to the user telling them what is wrong
    flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}" #will puts in string format rather then array format 
    #flash is part of active record and is used to communicate with user, errors get populated after certain method invocation
    #flash messiges only work if controller action ends with rederect becouse they sends new HTTP request where flash messiges live and they last only one rquest, new refresh of page they are lost
    redirect '/signup'
   end
  end
  #create save and update will trigger the validation
  #render is in get request, redirect in post

   # user SHOW route
  get "/users/:id" do #user.slog for finding by user name
    # what do I need to do first? I find user in bd asign to instance variable
    @user = User.find_by(id: params[:id])
    @pictures = @user.pictures 
    redirect_if_not_logged_in
    erb :"/users/show.html"
  end

  
  get '/my_pictures' do
    if logged_in?
      redirect "/users/#{current_user.id}"
      #erb :"/pictures/index.html"

    else
      redirect_if_not_logged_in
    end
  end 

  get '/logout' do
    session.clear
    redirect '/'
  end
end
