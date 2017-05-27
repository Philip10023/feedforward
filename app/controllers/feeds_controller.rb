class FeedsController < ApplicationController
  def index
    if Feed.search(params[:query])
      @feeds = Feed.search(params[:query])
    else
      @feeds = Feed.all
    end
  end

  def show
    @feed = Feed.find(params[:id])
  end

  def new
    if current_user.admin?
      @feed = Feed.new
    else
      flash[:notice] = 'You must be an admin to add a feed'
      redirect_to root_path
    end
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.save && current_user.admin?
      flash[:notice] = 'Feed successfully saved!'
      redirect_to @feed
    else
      render action: 'new'
    end
  end

  def destroy
    if current_user.admin?
      Feed.find(params[:id]).forwards.destroy_all
      Feed.find(params[:id]).destroy
      flash[:success] = "Feed deleted"
      redirect_to feeds_path, notice: "Feed Deleted"
    else
      redirect_to root_path
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:description, :url)
  end
end
