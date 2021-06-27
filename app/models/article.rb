class Article < ApplicationRecord
	validates :title, presence: true,
										length: { minimum: 5, maximum: 100 }
	validates :description, presence: true,
													length: { minimum: 10, maximum: 3000 }

	belongs_to :user
end
