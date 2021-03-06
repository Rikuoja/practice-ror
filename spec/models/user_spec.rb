require 'rails_helper'

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_wheat_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer2)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

RSpec.describe User, :type => :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with an improper password" do
    user = User.create username:"Pekka", password:"1", password_confirmation:"1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)

    user = User.create username:"Pekka", password:"aaaaa", password_confirmation:"aaaaa"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end

  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only one rated if only one rating" do
      create_beers_with_ratings(10, 20, user)
      expect(user.favorite_style.name).to eq("Lager")
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, user)
      create_wheat_beer_with_rating(22, user)

      expect(user.favorite_style.name).to eq("Weizen")
    end

  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only one rated if only one rating" do
      create_beer_with_rating(10, user)
      expect(user.favorite_brewery.name).to eq("anonymous")
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      create_wheat_beer_with_rating(22,user)

      expect(user.favorite_brewery.name).to eq("Brewdog")
      end

  end

end
