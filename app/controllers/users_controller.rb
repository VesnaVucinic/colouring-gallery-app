class UsersController < ApplicationController 
  get "/login" do
    redirect_if_logged_in
    erb :"login"
  end

  post "/login" do 
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id  
      redirect "/pictures" 
    else
      flash[:errors] = "Your credentials were invalid. Please sign up or try again."
      redirect "/login"
    end
  end

  get "/signup" do
    #render my sign form
    erb :"signup"
  end

  post "/users" do 
    @user = User.new(params)
    if @user.save
    session[:user_id] = @user.id 
    flash[:message] = "Welcome #{@user.name}! You have successfully created an account."
    redirect "/pictures"
   else
    flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}" 
    redirect '/signup'
   end
  end

   # user SHOW route
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
