require 'test_helper':

class TripInvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create(inviter, invitee, trip)" do
      Tripinvitation.create(users(:two),users(:three), trips(:two))
	  #assert(tripinvitations(:))
  end
  
  test "accept" do
  end
  
  test "decline" do
  end
  
  test "is_invitee(user)" do
  end
end
