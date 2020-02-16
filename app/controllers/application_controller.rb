require './config/environment'
#The classes that inherit from Sinatra::Base and define the HTTP interface for our application are called Controllers.
class ApplicationController < Sinatra::Base
#configure block tells the controller where to look to find the views (your pages with HTML to display text in the browser) and the public directory.
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secert_for_development"
    register Sinatra::Flash

  end
 #When a client makes a request to a server to load an application, the request is received and processed by the controller. We need to set up a controller action to accept the request and respond with the appropriate HTML.
  #We've created a controller action that can receive and respond to a GET request to the root URL '/'. This GET request loads the index.erb file.

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])#find returns error if is passed id that don't exist, find_by returns nill
      #@current user ||= reduces the calls to db by using tehnicque call memoization, first time current user is refernced within a 
      #scope of an instance of application controller this instance variable will be created and assigned if user is found otherwise
      #it'll be nill and that way subsequent call to current user if it's already populated won't hit the db again 
    end

    def authorized_to_edit?(picture)
      picture.user == current_user
    end

    # use this helper method to protect controller actions where user must be logged in to proceed
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page you tried to view."
        redirect '/'
      end
    end

    # use this helper method to avoid showing welcome, login, or signup page to a user that's already logged in
    def redirect_if_logged_in
      if logged_in?
        redirect "/users/#{current_user.id}"
      end
    end


  end

end
