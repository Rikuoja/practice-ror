class PlacesController < ApplicationController
  before_action :set_place, only: [:show]

  def index
  end

  def show
  end

  def search

    #save the last search for showing the place
    session[:last_city] = params[:city].downcase

    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  private

  def set_place

    #find the index in cached array
    place_index=Rails.cache.read(session[:last_city]).find_index{|place| place.send(:id)==params[:id]}
    @place = Rails.cache.read(session[:last_city])[place_index]
  end
end