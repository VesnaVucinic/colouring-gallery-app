require './config/environment'

if ActiveRecord::Migrator.needs_migration? #check to make sure our migrations have been run. If not, the error message is raised. The app will not function unless we’ve run our migrations first because we won’t have any information to display or manipulate
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#Rack::MethodOverride is a piece of Sinatra Middleware that intercepts (presrece) every request run by our application. It will interpret any requests with name="_method"
# by translating the request to whatever is set by the value attribute—normally PATCH or DELETE for purposes in our Sinatra curriculum.
# This line must be placed in the config.ru file above all controllers in which I want access to the Middleware’s functionality.
# in order to send PATCH and DELETE requests (request that are beyond get and post), when I use hidden input, I will need to add a line of code here with command use
use Rack::MethodOverride

# here is where I will mount other controllers with `use`

use PicturesController
use UsersController
run ApplicationController # This line creates an instance of our ApplicationController class that can respond to requests from a client. We can only run one class and the rest are loaded via use.
#our config.ru file contains the line run ApplicationController, which creates an instance of our ApplicationController class that can respond to requests from a client.


#gem called shotgun which allows you to start your Rack-based web app with an automatic code reloading feature.
# It starts up a Rack server and listens for any requests so when you hit the browser’s refresh button, you can see changes
# made to your code that have been saved. All you have to do is type shotgun in your terminal to start up a new session.
#Starting a new shotgun session  the first thing our app loads is our config.ru file, which on the very first line, requires our environment.rb file. 
#At this point, ENV["SINATRA_ENV"] will be set equal to "development" and the rest of our environment.rb file will execute, bringing us back to config.ru.
#Again, we have the chance of raising an error message of our config.ru file if we have not already run our migrations. However, this message simply says
# “Run rake db:migrate to resolve the issue” instead of “Run rake db:migrate SINATRA_ENV=test to resolve the issue” .
# It’s because of the line of code ENV["SINATRA_ENV"] ||= "development", which sets "development" as our default value for the "SINATRA_ENV" key.
# Since that’s the default, we don’t have to specify another "SINATRA_ENV" in our error message.