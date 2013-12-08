class Activity < ActiveRecord::Base
	belongs_to :trip
	acts_as_votable

	AMOUNT_REGEX = /\d+\.?\d{0,2}+/i
	validates :cost, :format => AMOUNT_REGEX,:numericality => {:greater_than_or_equal_to => 0, :less_than => 1000000}
	validates :topic, :presence => true, length: { maximum:25}


	def total_likes
		self.likes.size
	end



end
