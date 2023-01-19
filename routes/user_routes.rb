# frozen_string_literal: true

class MyApp < Sinatra::Base
  get '/users/:id' do
    env['warden'].authenticate!
    @user = User.find(params['id'])
    erb :"users/manage"
  end
  
  post '/users/:id' do
    env['warden'].authenticate!
    @user = User.find(params['id'])
    if params[:user][:password] != '' && params[:user][:password] == params[:user][:rpassword]
      @user.assign_attributes(
        username: params[:user][:username],
        password: BCrypt::Password.create(params[:user][:password])
      )
      @user.save
    end
    redirect to("/users/#{@user.id}")
  end
end
