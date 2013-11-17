class Activity < ActiveRecord::Base
	belongs_to :trip
	acts_as_votable

	def num_likes
		self.likes.size
	end

	def num_dislikes
		self.dislikes.size
	end
end
