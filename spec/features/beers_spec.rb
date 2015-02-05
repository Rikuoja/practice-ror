require 'rails_helper'


describe "Beer" do
  let!(:user) { FactoryGirl.create :user }

  #registered user is required for creating beers etc.!
  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when name given, can be created" do
    visit new_beer_path
    fill_in('beer[name]', with:'Olut')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "when name not given, cannot be created" do
    visit new_beer_path
    fill_in('beer[name]', with:'')

    click_button "Create Beer"
    expect(page).to have_content "Name can't be blank"

    expect(Beer.count).to eq(0)
  end
end