module Youtubemodule
  def youtube_embed(youtube_url)
    @youtube_id = YoutubeID.from(youtube_url)

    @youtube_video = "<iframe width='350' height='360' src='http://www.youtube.com/embed/#{@youtube_id}' frameborder='0' allowfullscreen></iframe>"
  end
    def self.included m
    return unless m < ActionController::Base
    m.helper_method :youtube_embed # , :any_other_helper_methods

  end
end

class FeedsController < ApplicationController
 include Youtubemodule
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
    @feed.user_id = current_user.id if current_user
    if @feed.save && current_user.admin?

      flash[:notice] = 'Feed successfully saved!'
      redirect_to feeds_path
    else
      render action: 'index'
    end
  end

  def destroy
    if current_user.admin?
      Feed.find(params[:id]).reviews.destroy_all
      Feed.find(params[:id]).destroy
      flash[:success] = "Feed deleted"
      redirect_to feeds_path, notice: "Feed Deleted"
    else
      redirect_to root_path
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:description, :url, :user_id)
  end
end
