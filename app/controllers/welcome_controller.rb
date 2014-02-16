class WelcomeController < ApplicationController
  def index
    @user_id = session[:user_id]
    @apartments = Apartment.all
    render(:index)
  end
end
