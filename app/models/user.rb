class User < ActiveRecord::Base
  include RatingMethods

  scope :admin, -> { where admin:true }
  scope :regular, -> { where admin:[nil,false] }

  scope :account_frozen, -> { where account_frozen:true}
  scope :active, -> { where account_frozen:[nil,false] }

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { in: 3..15 }

  validates :password, length: { minimum: 4 }

  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,  message: "has to contain one number and one upper case letter" }

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    rated_styles={}
    #enumerate with same style ratings chunked together:
    ratings.includes(:beer).order("Beers.style_id").chunk{ |rating| rating.beer.style}.each {
        |style, ratings|
        rated_styles[style]=average_rating_from ratings}
    rated_styles.max[0]   #max gives the [style, average] array with the highest average
  end

  def favorite_brewery
    return nil if ratings.empty?
    rated_breweries={}
    #enumerate with same brewery ratings chunked together:
    ratings.includes(:beer).order("Beers.brewery_id").chunk{ |rating| rating.beer.brewery}.each {
        |brewery, ratings|
      rated_breweries[brewery]=average_rating_from ratings}
    rated_breweries.max[0]   #max gives the [brewery, average] array with the highest average
  end


end
