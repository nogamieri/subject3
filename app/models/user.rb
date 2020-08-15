class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorited, source: :book
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name,
         uniqueness: {case_sensitive: :false},
         length: {minimum:2, maximum:20},
         presence: true

  validates :introduction, length: {maximum: 50}

  def favorited_by?(book_id)
  favorites.where(book_id: book_id).exists?
  end


end
