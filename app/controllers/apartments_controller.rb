class ApartmentsController < ApplicationController

  def index
    @apartments = Apartment.all
  end

  def show
    @apartment = Apartment.find(params[:id])
    @apartment.address = make_map_url(@apartment.address)
    @listings = @apartment.listings.all
  end

  def make_map_url(address)
    address = address.gsub(" ", "+")
  end

  def search
    @found_apartment = Apartment.where(address: params[:search_input] )

    if @found_apartment.count == 0
      @found_listing = Listing.find_by(url: params[:search_input])
      if @found_listing.nil?
        flash[:search_error_message] = "The apartment or listing you searched for does not exist in our database."
        redirect_to root_path
      else
        flash[:success_message] = "You found this apartment!"
        redirect_to apartment_path(@found_listing.apartment_id)
      end
    elsif @found_apartment.count > 1
      flash[:multiple_success_message] = "You found these apartments:"
      render(:search)
    else @found_apartment.count == 1
      flash[:success_message] = "You found this apartment!"
      redirect_to apartment_path(@found_apartment[0])
    end
  end
end