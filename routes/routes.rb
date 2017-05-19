# routes
# * you can have as many files as you like
# * make sure to not to have duplicate routes!
# These routes belong to "MyApp" and must inherit from "Sinatra::Base" in order to work.

class MyApp < Sinatra::Base
    get '/' do
        # use class/controller
        @welcome = Welcome.new
        @controller_name = @welcome.controller_name
        haml :index
    end

    get '/cave/:name' do
        #set the controller_name to make use of it in your layout
        @controller_name = 'hello'
        # matches "GET /hello/foo" and "GET /hello/bar"
        # params['name'] is 'foo' or 'bar'
        # @n stores params['name']
        @n = params['name']
        if @n == "Sinatra"
          haml :cave
        else
          haml "You yell: \"#{@n}\" into the dark cave. No echo."
        end
    end

    get '/time' do
        @controller_name = 'time'
        # edit timezone in config/timezone.rb
        @time = Time.now.to_local.strftime('%H:%M:%S')
        haml :time
    end

    get '/database' do
        haml :database
    end
end
