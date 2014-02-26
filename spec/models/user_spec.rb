require 'spec_helper'

describe User do
  let!(:tom) { User.create(email: "tom@tom.gmail.com", username: "tom", first_name: "Tom", last_name: "Tom", password: "tomtom", password_confirmation: "tomtom")}

  it { should have_many(:apartments) }
  it { should have_many(:reviews) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }
end