require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
                                 [ Place.new( name:"Oljenkorsi", id: 1 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned, they are all shown" do
    allow(BeermappingApi).to receive(:places_in).with("Ruoholahti").and_return(
                                 [ Place.new( name:"Kannas", id: 1 ),
                                   Place.new( name:"One pint", id: 2)]
                             )

    visit places_path
    fill_in('city', with: 'Ruoholahti')
    click_button "Search"

    expect(page).to have_content "Kannas"
    expect(page).to have_content "One pint"
  end

  it "if none are returned, the user is informed" do
    allow(BeermappingApi).to receive(:places_in).with("Otaniemi").and_return(
                                 []
                             )

    visit places_path
    fill_in('city', with: 'Otaniemi')
    click_button "Search"
    expect(page).to have_content "No locations in Otaniemi"
  end

end