# frozen_string_literal: true

class MyApp < Sinatra::Base
  get '/users/:id' do
    env['warden'].authenticate!

    begin
      @user = User.find(params['id'])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'Access denied'
      redirect '/'
    end

    # Ensure user can only access their own profile
    unless env['warden'].user.id == @user.id
      flash[:error] = 'Stop trying to hack'
      redirect '/'
    end

    erb :'users/manage'
  end

  post '/users/:id' do
    env['warden'].authenticate!

    begin
      @user = User.find(params['id'])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'Access denied'
      redirect '/'
    end

    # Ensure user can only modify their own account
    unless env['warden'].user.id == @user.id
      flash[:error] = 'Stop trying to hack'
      redirect '/'
    end

    if params[:user][:password] != '' && params[:user][:password] == params[:user][:rpassword]
      @user.assign_attributes(
        username: params[:user][:username],
        password: BCrypt::Password.create(params[:user][:password])
      )
      @user.save
      flash[:success] = 'Profile updated successfully'
    end
    redirect to("/users/#{@user.id}")
  end
end
