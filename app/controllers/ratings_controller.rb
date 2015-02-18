class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @top_beers = Beer.first.top 3
    @top_styles = Style.first.top 3
    @top_breweries = Brewery.first.top 3
    @most_active_users = User.first.most_ratings 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end