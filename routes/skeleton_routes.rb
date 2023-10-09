# frozen_string_literal: true

class MyApp < Sinatra::Base
  get '/skeletons' do
    # view that displays data, see: views/skeletons.erb
    # (skeleton in skeletons/skeleton.rb)
    @skeletons = Skeleton.all
    erb :'skeletons/skeletons'
  end

  # Database Interaction CRUD

  # "CREATE", part of the C in CRUD
  get '/new_skeleton_form' do
    env['warden'].authenticate!
    # view containing the form elements, see: views/form.erb)
    erb :'skeletons/new_skeleton_form'
  end

  post '/submit' do
    env['warden'].authenticate!
    # post route that handles the given form data and saves it to the database
    @skeleton = Skeleton.new(params[:skeleton])
    @skeleton.valid?
    if @skeleton.save
      flash[:success] = 'Skeleton successfully saved!'
      redirect '/skeletons'
    else
      @errors = @skeleton.errors
      erb :'skeletons/new_skeleton_form'
    end
  end

  # "EDIT", part of the U in CRUD
  get '/skeletons/:id/edit' do
    env['warden'].authenticate!
    @skeleton = Skeleton.find(params[:id])
    erb :'skeletons/edit_skeleton_form'
  end

  # "UPDATE", part of the U in CRUD
  post '/skeletons/:id' do
    env['warden'].authenticate!
    @skeleton = Skeleton.find(params[:id])
    if @skeleton.update_attributes(params[:skeleton])
      redirect to('/skeletons')
    else
      @errors = @skeleton.errors
      erb :'skeletons/edit_skeleton_form'
    end
  end

  # "DESTROY", the D in CRUD
  post '/skeletons/:id/destroy' do
    env['warden'].authenticate!
    @skeleton = Skeleton.find(params[:id])
    @skeleton.destroy
    flash[:success] = 'Skeleton successfully destroyed'
    redirect to('/skeletons')
  end
end
