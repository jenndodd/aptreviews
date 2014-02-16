class ApartmentsController < ApplicationController
  before_action( :load_apartment, only: [:show, :edit, :update] )

  def index
    @apartments = Apartment.all
  end

  def new
    @apartment = Apartment.new

    render(:new)
  end

  def create
    @apartment = Apartment.create(apartment_params)
    @user = User.find_by(id: session[:user_id])
    @apartment.user = @user
    if @apartment.save
      redirect_to apartments_path(@apartment)
    else
      render(:new)
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
    @user = User.find_by(params[:user_id])
    @url_address = make_map_url(@apartment.address)
    @listings = @apartment.listings.all
  end

  def edit
    @update_worked = true
  end

  def update
    @update_worked = @apartment.update(apartment_params)
    
    if @update_worked
      redirect_to apartment_path(@apartment)
    else
      render(:edit)
    end
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

  private

  def load_apartment 
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(:address, :unit)
  end



end