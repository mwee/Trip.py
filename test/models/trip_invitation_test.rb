require 'test_helper'
class TripInvitationTest < ActiveSupport::TestCase
  test "create(inviter, invitee, trip)" do
      TripInvitation.create(users(:two),users(:three), trips(:two))
	  new_invi = TripInvitation.where( inviter_id:1, invitee_id:2,trip_id:1)
	  assert_not_nil(new_invi)
	  assert_equal(new_invi.count,1)
  end
  
  test "accept" do
      invi1 = trip_invitations(:one)
	  invi1.accept()
	  assert(invi1.trip.users.member? users(:two))
	  invi2 = trip_invitations(:two)
	  invi2.accept()
	  assert(invi2.trip.users.member? users(:three))
  end
  
  test "is_invitee(user)" do
    assert_not(trip_invitations(:one).is_invitee(users(:one)));
	assert(trip_invitations(:one).is_invitee(users(:two)));
	assert_not(trip_invitations(:one).is_invitee(users(:three)));
  end
end
