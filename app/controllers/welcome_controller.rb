class WelcomeController < ApplicationController
  def index
    @apartments = Apartment.all
    render(:index)
  end
end
