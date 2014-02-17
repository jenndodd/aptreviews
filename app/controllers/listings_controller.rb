class ListingsController < ApplicationController

  def new
    @listing = Listing.new
    @apartment = Apartment.find(params[:apartment_id])
  end

  def create
    @listing = Listing.create(url: params[:listing][:url], apartment_id: params[:apartment_id])

    redirect_to ("/apartments/#{ params[:apartment_id] }")
  end
end