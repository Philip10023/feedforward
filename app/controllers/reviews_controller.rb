class ReviewsController < ApplicationController
  def index
    if user_signed_in? && current_user.admin?
      @reviews = Review.all
      @feeds = Feed.all
    else
      redirect_to root_path
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def destroy
    if current_user.admin?
      Review.find(params[:id]).destroy
      flash[:success] = "Review deleted"
      redirect_to feeds_path, notice: "Review Deleted"
    else
      redirect_to root_path
    end
  end
end
