class Activity < ActiveRecord::Base
	belongs_to :trip
	acts_as_votable

	def total_likes
		self.likes.size
	end

end
