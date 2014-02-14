class ApartmentsController < ApplicationController
  def show
    @apartment = Apartment.find(params[:id])
    @apartment.address = make_map_url(@apartment.address)
  end

  def make_map_url(address)
    address = address.gsub(" ", "+")
  end
end