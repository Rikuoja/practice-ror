require 'rails_helper'


describe "Beer" do

  before :each do

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