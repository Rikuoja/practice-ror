require 'rails_helper'

MembershipsController
BeerClubsController

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

RSpec.describe Beer, :type => :model do
  it "is not saved without a name" do
    beer = Beer.create

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Testiolut"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  describe "with a name and style" do
    let(:beer){ Beer.create name:"Testiolut", style:"Weizen" }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end
