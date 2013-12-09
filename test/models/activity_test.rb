require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
	def test_total_likes
		user1 = User.get_user('liyihuaxin@126.com')
		user2 = User.get_user('liyixinhua@126.com')
		act = Activity.find(1)
		assert_equal(act.total_likes, 0)
		act.liked_by user1
		assert_equal(act.total_likes, 1)
		act.liked_by user2
		assert_equal(act.total_likes, 2)
		act.unliked_by user1
		assert_equal(act.total_likes, 1)
		act.unliked_by user2
		assert_equal(act.total_likes, 0)
	end

	def test_one_like_allowed
		user1 = User.get_user('liyihuaxin@126.com')
		act = Activity.find(2)
		assert_equal(act.total_likes, 0)
		act.liked_by user1
		assert_equal(act.total_likes, 1)
		act.liked_by user1
		assert_equal(act.total_likes, 1)		
		act.unliked_by user1
		assert_equal(act.total_likes, 0)
		act.unliked_by user1
		assert_equal(act.total_likes, 0)
	end
end
	