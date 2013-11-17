class Activity < ActiveRecord::Base
	belongs_to :trip
	acts_as_votable
end
