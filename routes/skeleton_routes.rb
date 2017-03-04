class MyApp < Sinatra::Base
    get '/skeletons' do
        # view that displays data, see: views/skeletons.haml
        # (skeleton in skeletons/skeleton.rb)
        @skeletons = Skeleton.all
        haml :"skeletons/skeletons"
    end

    # Database Interaction CRUD
    
    # "CREATE", part of the C in CRUD
    get '/new_skeleton_form' do
        env['warden'].authenticate!
        # view containing the form elements, see: views/form.haml)
        haml :"skeletons/new_skeleton_form"
    end
    post '/submit' do
        env['warden'].authenticate!
        # post route that handles the given form data and saves it to the database
        @skeleton = Skeleton.new(params[:skeleton])
        if @skeleton.save
            redirect '/skeletons'
        else
            haml :"skeletons/new_skeleton_form"
        end
    end

    # "EDIT", part of the U in CRUD
    get '/skeletons/:id/edit' do
        env['warden'].authenticate!
        @skeleton = Skeleton.find(params[:id])
        haml :"skeletons/edit_skeleton_form"
    end

    # "UPDATE", part of the U in CRUD
    post '/skeletons/:id' do
        env['warden'].authenticate!
        @skeleton = Skeleton.find(params[:id])
        if @skeleton.update_attributes(params[:skeleton])
            redirect to('/skeletons')
        else
            haml :"skeletons/edit_skeleton_form"
        end
    end

    # "DESTROY", the D in CRUD
    post '/skeletons/:id/destroy' do
        env['warden'].authenticate!
        @skeleton = Skeleton.find(params[:id])
        @skeleton.destroy
        redirect to('/skeletons')
    end
end
