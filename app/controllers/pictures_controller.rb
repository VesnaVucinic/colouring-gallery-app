class PicturesController < ApplicationController
#was nit DRY - don't repit yourself, that is why we added new helper methods
  # GET: /pictures
  get "/pictures" do
    @pictures = Picture.all
    erb :"/pictures/index.html"
  end

  # GET: /pictures/new  to render a form to create new picture
  get "/pictures/new" do# inside erb route flash messiges don't work, work only inside new HTTP request - redirect, erb are not new request, create, update and delete ends in rederect. In erb I don't need flash messiges, in erb I can create instance variable that will survive on to the view
    redirect_if_not_logged_in #protect this rout
    erb :"/pictures/new.html"
  end

  # POST: /pictures to create a new pictures
  post "/pictures" do
    redirect_if_not_logged_in
    # I want to create a new picture and save it to the DB
    # I also only want to create a picture if a user is logged in
    # I only want to save the picture if it has some content
    if params[:title] != "" && params[:description] != "" && params[:image_url] != ""
       # create a new picture
      @picture = Picture.create(title: params[:title], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
      flash[:message] = "Picture successfully created." if @picture.id 
      redirect "/pictures/#{@picture.id}"
    else
      flash[:errors] = "Something went wrong - you must provide title, url and description for your new picture."
      #flash[:error] = "Picture creation failed: #{picture.errors.full_messages.to_sentence}"
      redirect "/pictures/new"
    end
  end

  # GET: /pictures/5,show rout will show what already exist
  get "/pictures/:id" do
    set_picture
    erb :"/pictures/show.html"
  end

    # *** MAJOR PROBLEMS!!! ***
  # 1. RIGHT NOW, ANYONE CAN EDIT ANYONE ELSE'S PICTURES!!!!
  # 2. ALSO, I CAN EDIT A PICTURE TO BE BLANK!!!!!

  # This route should send us to pictures/edit.erb, which will
  # render an edit form

  # GET: /pictures/5/edit, render form edit
  get "/pictures/:id/edit" do
    redirect_if_not_logged_in
    set_picture
      if @picture.user == current_user && params[:title] != "" && params[:description] != "" && params[:image_url] = ""
        erb :"/pictures/edit.html"
      else
        redirect "users/#{current_user.id}"
      end
  end

  # PATCH: /pictures/5/modifie-update what is edited 
  patch "/pictures/:id" do
    redirect_if_not_logged_in
    # 1. find the picture
    set_picture
      if authorized_to_edit?(@picture)
      #if @picture.user == current_user && params[:title] != "" && params[:description] != "" && params[:image_url] != ""
        # 2. modify (update) the picture
        @picture.update(title: params[:title], description: params[:description], image_url: params[:image_url])#this is one big hash , I ommited{}, and it still one argument
        # 3. redirect to show page
        redirect "/pictures/#{@picture.id}"
      else
        redirect "users/#{current_user.id}"
      end
  end

  # DELETE: /pictures/5/delete
  #diff between delete and destroy:destroy runs any callbacks on the model delete doesn't and destroy remove associate children. Callbecks are methods that ask to do something befor action 
  delete "/pictures/:id/delete" do
    set_picture
    if authorized_to_edit?(@picture)
      @picture.destroy
      flash[:message] = "Picture successfully deleted."
      redirect "users/#{current_user.id}"#not to render becouse of separation of concerns, delete action is to simply delete and when is that done redirect somewhere, not job to show us something. Delete, pach and post request actions end in rederct not job to show that do get.
    else
      redirect "/pictures"
    end
  end

  private #helper method, call private becouse no use outside this class

  def set_picture #when I invoke method return value is value of instance variable @picture
    @picture = Picture.find(params[:id])
  end
end
