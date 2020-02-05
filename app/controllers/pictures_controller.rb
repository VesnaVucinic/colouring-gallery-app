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
    redirect "/pictures"
  end

  # GET: /pictures/5
  get "/pictures/:id" do
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
