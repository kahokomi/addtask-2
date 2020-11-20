class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(search,search_word)
		if search == "forward_match"
			@book = Book.where("title LIKE?", "#{search_word}%")
		elsif search == "backward_match"
			@book = Book.where("title LIKE?", "%#{search_word}")
		elsif search == "perfect_match"
			@book = Book.where("title LIKE?", "#{search_word}")
		elsif search == "partial_match"
			@book = Book.where("title LIKE?", "%#{search_word}%")
		else
			@book = Book.all
		end
	end
end