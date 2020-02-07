class PicturesController < ApplicationController

  # GET: /pictures
  get "/pictures" do
    @pictures = Picture.all
    erb :"/pictures/index.html"
  end

  # GET: /pictures/new
  get "/pictures/new" do
    erb :"/pictures/new.html"
  end

  # POST: /pictures
  post "/pictures" do
    if !logged_in?
      redirect "/"
    end
    if params[:title] != "" && params[:description] != "" && params[:image_url]
      @picture = Picture.create(title: params[:title], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
      redirect "/pictures/#{@picture.id}"
    else
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
      if @picture.user == current_user
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
      if @picture.user == current_user && params[:title] != "" && params[:description] != "" && params[:image_url]
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
  delete "/pictures/:id/delete" do
    set_picture
    if authorized_to_edit?(@picture)
      @picture.destroy
      redirect "users/#{current_user.id}"
    else
      redirect "/pictures"
    end
  end

  private #helper method, call private becouse no use outside this class

  def set_picture #when I invoke method return value is value of instance variable @picture
    @picture = Picture.find(params[:id])
  end
end
