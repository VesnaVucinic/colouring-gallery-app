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
    @picture = Picture.find(params[:id])
    erb :"/pictures/show.html"
  end

  # GET: /pictures/5/edit
  get "/pictures/:id/edit" do
    erb :"/pictures/edit.html"
  end

  # PATCH: /pictures/5
  patch "/pictures/:id" do
    redirect "/pictures/:id"
  end

  # DELETE: /pictures/5/delete
  delete "/pictures/:id/delete" do
    redirect "/pictures"
  end
end
