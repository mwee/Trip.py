require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def test_is_friend
    assert(Friendship.is_friend?(1, 2))
    assert_not(is_friend?(1, 3))
  end

  def test_is_friend_self
    assert(Friendship.is_friend?(1, 1))
  end

  def test_is_invited
    friendship=friendships(:one)
    assert_equal(friendship.user_id,1)
    assert_equal(friendship.status,'pending')
    assert(friendship.is_invited?(2))
    assert_not(friendship.is_invited?(1))
    assert_not(friendship.is_invited?(3))
    assert_not(friendship.is_invited?(4))
  end

  def test_getReceivedInvitation_single
    friendships=Friendship.getReceivedInvitation(3)
    assert_equal(friendship.user_id,4)
    
  end

  def test_getReceivedInvitation_collection
    friendships=Friendship.getReceivedInvitation(1)
    
  end  
  
end
