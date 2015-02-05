require 'rails_helper'


describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:"Lager" }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:"Lager" }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user2 }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "number is shown on ratings page" do
    FactoryGirl.create :rating, beer:beer1, score:12, user:user
    FactoryGirl.create :rating, beer:beer2, score:15, user:user

    visit ratings_path
    expect(page).to have_content 'Number of ratings: 2'
    expect(page).to have_content 'iso 3'
    expect(page).to have_content 'Karhu'

  end

  it "is shown on user page only" do
    FactoryGirl.create :rating, beer:beer1, score:12, user:user
    FactoryGirl.create :rating, beer:beer2, score:15, user:user
    FactoryGirl.create :rating, beer:beer1, score:13, user:user2

    visit user_path(user)
    expect(page).to have_content 'made 2 ratings'
    expect(page).to have_content 'iso 3'
    expect(page).to have_content 'Karhu'

  end

  it "gives highest rated style on user page" do
    FactoryGirl.create :rating, beer:beer1, score:12, user:user

    visit user_path(user)
    expect(page).to have_content 'Favorite style is Lager'

  end

  it "gives highest rated brewery on user page" do
    FactoryGirl.create :rating, beer:beer1, score:12, user:user

    visit user_path(user)
    expect(page).to have_content 'Favorite brewery is Koff'

  end

  it "can be removed by user" do
    FactoryGirl.create :rating, beer:beer1, score:12, user:user

    visit user_path(user)
    expect{
      click_on 'delete'
    }.to change{Rating.count}.from(1).to(0)
    end
end