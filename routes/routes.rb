# frozen_string_literal: true

# routes
# * you can have as many files as you like
# * make sure to not to have duplicate routes!
# These routes belong to "MyApp" and must inherit from "Sinatra::Base" in order to work.
# Check out Sinatra's buddy Musterman:
# https://github.com/sinatra/mustermann/blob/master/mustermann/README.md#-parameter-parsing

class MyApp < Sinatra::Base
  get '/' do
    # use class/controller
    @welcome = Welcome.new
    @controller_name = @welcome.controller_name
    erb :index
  end

  get '/cave/:name' do
    # set the controller_name to make use of it in your layout
    @controller_name = 'hello'
    # matches "GET /hello/foo" and "GET /hello/bar"
    # params['name'] is 'foo' or 'bar'
    # @n stores params['name']
    @name = params['name']
    if @name == 'Sinatra'
      erb :cave
    else
      erb "You yell: \"#{@name}\" into the dark cave. No echo."
    end
  end

  get '/time' do
    @controller_name = 'time'
    # edit timezone in config/timezone.rb
    @time = Time.now.to_local.strftime('%H:%M:%S')
    erb :time
  end

  get '/database' do
    erb :database
  end
end
