class ListingsController < ApplicationController

  def new
    @listing = Listing.new
    @apartment = Apartment.find(params[:apartment_id])
  end

  def create
    @listing = Listing.create(url: params[:listing][:url], apartment_id: params[:apartment_id])

    redirect_to apartment_path(params[:apartment_id])
  end

  def edit
    @update_worked = true
  end

  def update
    @update_worked = @review.update(review_params)
    
    if @update_worked
      redirect_to apartment_path(params[:apartment_id])
    else
      render(:edit)
    end
  end
end