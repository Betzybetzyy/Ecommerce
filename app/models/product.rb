class Product < ApplicationRecord
  include PgSearch::Model
  include Favoritable
  
  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B'
  }
  ORDER_BY = {
    newest: "created_at DESC",
    expensive: "price DESC",
    cheapest: "price ASC"
  }
  has_one_attached :photo
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  belongs_to :category
  belongs_to :user, default: -> { Current.user }

  def owner?
    user_id == Current.user&.id
  end

  def favorite!
    favorites.create(user: Current.user)
  end

  def unfavorite!
    favorite.destroy
  end

  def favorite
    favorites.find_by(user: Current.user)
  end
end