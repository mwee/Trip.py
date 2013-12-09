require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def test_is_friend
    assert(Friendship.is_friend?(1, 2))
    assert_not(Friendship.is_friend?(1, 4))
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
    friendship=Friendship.getReceivedInvitation(3)
    assert_equal(friendship.count,1)
    assert_equal(friendship.first.status,"pending")
    assert_equal(friendship.first.user_id,4)
  end

  def test_getReceivedInvitation_collection
    friendships=Friendship.getReceivedInvitation(2)
    assert_equal(friendships.count,2)
    assert_equal(friendships.first.status,"pending")
    assert_equal(friendships.first.user_id,1)
    assert_equal(friendships.last.status,"pending")
    assert_equal(friendships.last.user_id,4)
  end

  def test_update
    friendship=friendships(:one)
    friendship.update
    assert_equal(friendship.status,"finalized")
  end

  def test_update_finalized
    friendship=friendships(:two)
    friendship.update
    assert_equal(friendship.status,"finalized")
  end

  def test_createInverse
      friendship=friendships(:two)
      friendship.createInverse
      new_friendship=Friendship.where(user_id:3, friend_id:2,status:"finalized")
      assert_not_nil(new_friendship)
      assert_equal(new_friendship.count,1)
      
  end

  def test_createInverse_already_exist
      friendship=friendships(:seven)  
      friendship.createInverse
      new_friendship=Friendship.where(user_id:3, friend_id:1,status:"finalized")
      assert_not_nil(new_friendship)
      assert_equal(new_friendship.count,1)
  end

  def test_updateId
    Friendship.updateId('100001837462039', 4)
    friendship=friendships(:six)
    assert_equal(friendship.friend_id,4)
  end
end
