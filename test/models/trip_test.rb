require 'test_helper'

class TripTest < ActiveSupport::TestCase
  def test_get_all_trips
    user=User.find(1)
	trips=Trip.get_all_trips(user)
	assert_equal(trips.length,3)
	user4=User.find(4)
	trips4=Trip.get_all_trips(user4)
    assert_equal(trips4.length,0)
  end
  
  def test_user_is_creator(user)
     user1=User.find(1)
     trip1=Trip.find(1)
	 assert(trip1.user_is_creator(user1))
	 user2=User.find(2)
	 trip2=Trip.find(4)
	 assert(trip2.user_is_creator(user2))
	 assert_not(trip2.user_is_creator(user1))
  end
  
end
