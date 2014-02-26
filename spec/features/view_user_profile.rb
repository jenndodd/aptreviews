require 'spec_helper'

describe "user can view their profile page" do

  let!(:user) { User.create(email: "tom@tom.gmail.com", username: "tom", first_name: "Tom", last_name: "Tom", password: "tomtom", password_confirmation: "tomtom") }
  let!(:apartment) { Apartment.create(user: user, unit: "4a", number: "305", street: "South Ave W", city: "Westfield", state: "NJ", address: "305 South Ave W, Westfield, NJ", beds: "1", baths: "1", rent: "1,150") }
  let!(:review) { Review.create(apartment: apartment, user: user, title: "Oh,hey", review: "This is a sweet review.", rating: 4)}
  
  it "views their profile" do

    login(user)
    visit root_path

    click_link "profile"

    within ".center-content" do
      expect(page).to have_content user.first_name
      expect(page).to have_content apartment.address
      save_and_open_page
      expect(page).to have_content review.title
    end
  end

  def login(user)
    visit login_path
    fill_in :username, with: user.username
    fill_in :password, with: user.password
    click_button "Log in!"
  end
end