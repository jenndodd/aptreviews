class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @apartment = Apartment.find(params[:apartment_id])

    render(:new)
  end

  def create
    @review = Review.create(review_params)
    @apartment = Apartment.find(params[:apartment_id])
    @user = User.find_by(id: session[:user_id])
    @review.datetime = DateTime.now
    @review.user = @user
    @review.apartment = @apartment
    if @review.save
      redirect_to ("/apartments/#{ @apartment.id }")
    else
      render(:new)
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :review, :rating)
  end


end