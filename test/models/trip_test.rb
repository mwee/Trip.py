require 'test_helper'
class TripTest < ActiveSupport::TestCase

  test "get_all_trips" do
    user1=users(:one)
	user2=users(:two)
	user3=users(:three)
	trip1=trips(:one)
	trip2=trips(:two)	
	trip3=trips(:three)
	trip4=trips(:four)
	assert_equal(Trip.get_all_trips(user1),[trip1,trip2,trip3])
	assert_equal(Trip.get_all_trips(user2),[trip4])
	assert_equal(Trip.get_all_trips(user3),[])
	user1.created_trips << trip4
	user3.created_trips << trip2
	assert_equal(Trip.get_all_trips(user1),[trip1,trip2,trip3,trip4])
	assert_equal(Trip.get_all_trips(user2),[trip4])
	assert_equal(Trip.get_all_trips(user3),[trip2])
  end
  
  test "user_is_creator" do
    user1=users(:one)
	user2=users(:two)
	user3=users(:three)
	trip1=trips(:one)
	trip4=trips(:four)	
	assert(trip1.user_is_creator(user1))
	assert_not(trip1.user_is_creator(user2))
	assert_not(trip1.user_is_creator(user3))			
	assert_not(trip4.user_is_creator(user1))
	assert(trip4.user_is_creator(user2))
	assert_not(trip4.user_is_creator(user3))
  end
  
  test "user_in_cabal" do
    user1=users(:one)
	user2=users(:two)
	user3=users(:three)
	trip1=trips(:one)
	assert(trip1.user_is_member(user1))
	assert_not(trip1.user_is_member(user2))
	trip1.users << user2
	assert(trip1.user_is_member(user1))
	assert(trip1.user_is_member(user2))
	assert_not(trip1.user_is_member(user3))
  end
  
 test "user_is_member" do
    user1=users(:one)
	user2=users(:two)
	user3=users(:three)
	user4=users(:four)
	assert(trips(:one).user_is_member(user1))
	assert_not(Trip.find(1).user_is_member(user2))
	trips(:one).users << user2
	Trip.find(1).users << user3
	assert(trips(:one).user_is_member(user1))
	assert(trips(:one).user_is_member(user2))
	assert(trips(:one).user_is_member(user3))
	assert_not(trips(:one).user_is_member(user4))
  end
  
  test "get_status" do
  	assert_equal(trips(:one).get_status, "Active")
	assert_equal(trips(:two).get_status, "Finalized")
  end
	
  test "get_uninvited_friends and get uninvited friends" do
    user1=users(:one)
	user2=users(:two)
	user3=users(:three)
	user4=users(:four)	
	user1.friends << user2
	user1.friends << user3
	user1.friends << user4
	trip1=trips(:one)
	assert_equal(trip1.get_uninvited_friends(user1),[user3,user4])
	assert_equal(trip1.get_free_uninvited_friends(user1),[user4])
	TripInvitation.create(user2,user3, trip1)
	assert_equal(trip1.get_uninvited_friends(user1),[user4])
	assert_equal(trip1.get_free_uninvited_friends(user1),[user4])
  end
  
  test "finalize" do
    trip1= trips(:one)
	trip2= trips(:two)
  	assert(trip1.active)
	assert_not(trip2.active)
	trip1.finalize
	assert_not(trip1.active)
	assert_not(trip2.active)
  end
  
  test "is_active" do
  	assert(trips(:one).is_active)
	assert_not(trips(:two).is_active)
  end
  
end
