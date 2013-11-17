class Freerange < ActiveRecord::Base
	belongs_to :user
	validates_date :start_date, :on_or_after => Time.now
	validates_date :end_date, :on_or_after => :start_date
end
