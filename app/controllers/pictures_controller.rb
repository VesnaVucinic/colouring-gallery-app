class PicturesController < ApplicationController

  get "/pictures" do 
    @pictures = Picture.all
    erb :"/pictures/index.html"
  end

  get "/pictures/new" do
    redirect_if_not_logged_in 
    erb :"/pictures/new.html" 
  end

  post "/pictures" do 
    redirect_if_not_logged_in 
    if params[:title] != "" && params[:description] != "" && params[:image_url] != ""
      @picture = Picture.create(title: params[:title], description: params[:description], image_url: params[:image_url], user_id: current_user.id)
      flash[:message] = "Picture successfully created." if @picture.id 
      redirect "/pictures/#{@picture.id}"
    else
      flash[:errors] = "Something went wrong - you must provide title, url and description for your new picture."
      redirect "/pictures/new"
    end
  end

  get "/pictures/:id" do
    set_picture
    erb :"/pictures/show.html" 
  end

  get "/pictures/:id/edit" do
    redirect_if_not_logged_in
    set_picture
      if authorized_to_edit?(@picture)
        erb :"/pictures/edit.html"
      else
        redirect "users/#{current_user.id}"
      end
  end

  patch "/pictures/:id" do
    redirect_if_not_logged_in
    set_picture  
      if authorized_to_edit?(@picture)
        @picture.update(title: params[:title], description: params[:description], image_url: params[:image_url])
        redirect "/pictures/#{@picture.id}"
      else
        redirect "users/#{current_user.id}"
      end
  end

  delete "/pictures/:id/delete" do
    set_picture
    if authorized_to_edit?(@picture)
      @picture.destroy
      flash[:message] = "Picture successfully deleted."
      redirect "users/#{current_user.id}"
    else
      redirect "/pictures"
    end
  end

  private 

    def set_picture 
      @picture = Picture.find(params[:id])
    end

  
end
