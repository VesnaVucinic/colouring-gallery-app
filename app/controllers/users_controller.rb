class UsersController < ApplicationController
 
  #render v rederect: access to variables only with render
  # route to render the login page (form)
  get "/login" do
    erb :"login"
  end
 
  # route to receive the login form
  post "/login" do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #flash[:message] = "Welcome, #{@user.name}!"
      redirect "/pictures" 
    else
      flash[:errors] = "Your credentials were invalid. Please sign up or try again."
      redirect "/login"
    end
  end

  # get sign up route that renders signup form
  get "/signup" do
    #render my sign form
    erb :"signup"
  end
   
  post "/users" do #with create if I create new user inside if block @user.error will give @user nill)
    @user = User.new(params)# I moved User.create abov if block and put User.new
    #if params[:name] != "" && params[:email] != "" && params[:password] != "" #when I put new and validation in model I dont need this
    if @user.save
    session[:user_id] = @user.id
    flash[:message] = "You have successfully created an account, #{@user.name}! Welcome!"
    redirect "/users/#{@user.id}"
   else
    flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}" #will puts in string format rather then array format 
    #flash is part of active record and is used to communicate with user, errors get populated after certain method invocation
    #flash messiges only work if controller action ends with rederect becouse they sends new HTTP request wher flash messiges live and they last only one rquest, new refresh of page they are lost
    redirect '/signup'
   end
  end
  #create save and update will trigger the validation


  # GET: /users/5
  get "/users/:id" do
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
