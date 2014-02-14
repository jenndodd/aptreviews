class ApartmentsController < ApplicationController
  def show
    @apartment = Apartment.find(params[:id])
    @apartment.address = make_map_url(@apartment.address)
  end

  def make_map_url(address)
    address = address.gsub(" ", "+")
  end

  def search
    @found_apartment = Apartment.where(address: params[:address] )

    if @found_apartment.count == 0
      flash[:search_error_message] = "The apartment you searched for does not exist in our database."
      redirect_to root_path
    elsif @found_apartment.count > 1
      flash[:multiple_success_message] = "You found these apartments:"
      render(:search)
    else @found_apartment.count == 1
      flash[:success_message] = "You found this apartment!"
      redirect_to apartment_path(@found_apartment[0])
    end

  end
end