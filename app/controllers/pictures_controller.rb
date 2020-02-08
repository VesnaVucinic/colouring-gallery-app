class PicturesController < ApplicationController

  # GET: /pictures
  get "/pictures" do
    @pictures = Picture.all
    erb :"/pictures/index.html"
  end

  # GET: /pictures/new
  get "/pictures/new" do# inside erb route flash messiges don't work, work only inside new HTTP request - redirect, erb are not new request, create, update and delete ends in rederect. In erb I don't need flash messiges, in erb I can create instance variable that will survive on to the view
    erb :"/pictures/new.html"
  end

  # POST: /pictures
  post "/pictures" do
    if !logged_in?
      redirect "/"
    end
    if params[:title] != "" && params[:description] != "" && params[:image_url]
      @picture = Picture.create(title: params[:title], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
      flash[:message] = "Picture successfully created." 
      redirect "/pictures/#{@picture.id}"
    else
      #flash[:errors] = "Something went wrong - you must provide title,url and description for your new picture."
      flash[:error] = "Picture creation failed: #{picture.errors.full_messages.to_sentence}"
      redirect "/pictures/new"
    end
  end

  # GET: /pictures/5,show rout will show what already exist
  get "/pictures/:id" do
    set_picture
    erb :"/pictures/show.html"
  end

  # GET: /pictures/5/edit, render form edit
  get "/pictures/:id/edit" do
    set_picture
    if logged_in?
      if @picture.user == current_user && params[:title] != "" && params[:description] != "" && params[:image_url] = ""
        erb :"/pictures/edit.html"
      else
        redirect "users/#{current_user.id}"
      end
    else
      redirect "/"
    end
  end

  # PATCH: /pictures/5/modifie-update what is edited 
  patch "/pictures/:id" do
    set_picture
    if logged_in?
      if @picture.user == current_user && params[:title] != "" && params[:description] != "" && params[:image_url] != ""
        @picture.update(title: params[:title], description: params[:description], image_url: params[:image_url])#this is one big hash , I ommited{}, and it still one argument
      redirect "/pictures/#{@picture.id}"
      else
        redirect "users/#{current_user.id}"
      end
    else
      redirect "/"
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
