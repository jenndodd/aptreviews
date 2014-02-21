class ApartmentsController < ApplicationController
  before_action( :load_apartment, only: [:show, :edit, :update, :nearby, :make_map_url] )
  before_action( :load_user, only: [:create, :show])

  def index
    @apartments = Apartment.all
  end

  def new
    @apartment = Apartment.new

    render(:new)
  end

  def create
    @apartment = Apartment.create(apartment_params)
    @numbstreet = [@apartment.number, @apartment.street].compact.join(' ')
    @apartment.address = [@numbstreet, @apartment.city, @apartment.state].compact.join(', ')
    @apartment.user = @user
    if @apartment.save
      redirect_to apartment_path(@apartment)
    else
      render(:new)
    end
  end

  def show
    @creator = User.find(@apartment.user_id)
    @map_url_address = make_map_url
    @listings = @apartment.listings.all
    @listing = Listing.new
    @reviews = @apartment.reviews.all
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

  def make_map_url
    @apartment_url = @apartment.address.gsub(" ", "+")
    return "http://maps.googleapis.com/maps/api/staticmap?center=#{ @apartment_url }&size=400x400&zoom=15&markers=color:0xe062e2%7Clabel:O%7C#{ @apartment_url }&sensor=false&style=feature:road.highway|element:geometry|hue:0x00ffdd|saturation:-65|lightness:30&style=feature:road.arterial|element:geometry|hue:0x4d00ff|visibility:simplified&style=feature:water|hue:0x0077ff|saturation:-52|lightness:-15"
  end

  def search
    @found_apartment = Apartment.where(address: params[:search_input])

    if @found_apartment.count == 0
      @found_listing = Listing.find_by(url: params[:search_input])
      if @found_listing.nil?
        @found_apartment = Apartment.where(city: params[:search_input])
        if @found_apartment.count == 0
          flash[:search_error_message] = "The apartment or listing you searched for does not exist in our database."
          redirect_to apartments_path
        elsif @found_apartment.count > 1
          render(:search)
        else @found_apartment.count == 1
          redirect_to apartment_path(@found_apartment[0][:id])
        end 
      else
        redirect_to apartment_path(@found_listing.apartment_id)
      end
    elsif @found_apartment.count > 1
      render(:search)
    else @found_apartment.count == 1
      redirect_to apartment_path(@found_apartment[0][:id])
    end
  end

  def nearby
    @apartment_url = @apartment.address.gsub(" ", "+")
    @nearby_apartments = Apartment.near(@apartment.address, 1).limit(10)
    @nearby_apartments.delete_if {|apartment| apartment == @apartment}

    if @nearby_apartments.empty?
      @nearby_url = "http://maps.googleapis.com/maps/api/staticmap?center=#{ @apartment_url }&size=400x400&zoom=15&markers=color:0xe062e2%7Clabel:O%7C#{ @apartment_url }&sensor=false&style=feature:road.highway|element:geometry|hue:0x00ffdd|saturation:-65|lightness:30&style=feature:road.arterial|element:geometry|hue:0x4d00ff|visibility:simplified&style=feature:water|hue:0x0077ff|saturation:-52|lightness:-15"
    else
      @nearby_apartments_url = []
      @nearby_apartments.each_with_index do |nearby_apartment, index|
        @nearby_apartments_url << "markers=color:0x75D2C3%7Clabel:#{index+1}%7C#{ nearby_apartment.address.gsub(" ", "+") }&"
      end    
      @nearby_url = "http://maps.googleapis.com/maps/api/staticmap?center=#{ @apartment_url }&size=400x400&zoom=14&markers=color:0xe062e2%7Clabel:O%7C#{ @apartment_url }&#{@nearby_apartments_url.join}&sensor=false&style=feature:road.highway|element:geometry|hue:0x00ffdd|saturation:-65|lightness:30&style=feature:road.arterial|element:geometry|hue:0x4d00ff|visibility:simplified&style=feature:water|hue:0x0077ff|saturation:-52|lightness:-15"
    end
  end 

  private

  def load_apartment 
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(:number, :street, :city, :state, :unit, :beds, :baths, :rent, :extras)
  end

  def load_user
    @user = User.find_by(params[:user_id])
  end

end