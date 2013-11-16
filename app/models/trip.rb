class Trip < ActiveRecord::Base
     has_one :daterange
     has_and_belongs_to_many :users, :join_table => :added_trips
     belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
end
