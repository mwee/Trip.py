require 'test_helper'
class TripInvitationTest < ActiveSupport::TestCase
  test "create(inviter, invitee, trip)" do
      Tripinvitation.create(users(:two),users(:three), trips(:two))
	  assert(Tripinvitations.where(:))
  end
  
  test "accept" do
      invi1 = trip_invitations(:one)
	  invi1.accept()
	  assert(invi1.trip.users.member? users(:two))
	  invi2 = trip_invitations(:two)
	  invi2.accept()
	  assert(invi2.trip.users.member? users(:three))
	  assert_nil(invi2)
  end
  
  test "decline" do
      invi1 = trip_invitations(:one)
	  invi1.decline()
	  assert(invi1.nil?)
  end
  
  test "is_invitee(user)" do
    assert_not(trip_invitations(:one).is_invitee(users(:one)));
	assert(trip_invitations(:one).is_invitee(users(:two)));
	assert_not(trip_invitations(:one).is_invitee(users(:three)));
  end
end
