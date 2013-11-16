class Daterange < ActiveRecord::Base
    belongs_to :user
	
	#Return true the start_date is before or the same as the end date
	def is_valid_range
	end
	
	#Return true the start_date is the same as the end date
	def is_one_date
	end
end
