require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_get_user
    user=User.get_user('liyihuaxin@126.com')
    assert_equal(user.id,1)
    assert_equal(user.name,'Yihua')
    assert_equal(user.uid,'100001773732177')
    assert_equal(user.gender,'female')
    assert_equal(user.provider,'facebook')
  end

  def test_get_user_invalid
    user=User.get_user('4154@mit.edu')
    assert_nil(user)
  end

  def test_get_facebook_user
    user=User.get_facebook_user('100001773732177')
    assert_equal(user.id,1)
    assert_equal(user.name,'Yihua')
    assert_equal(user.email,'liyihuaxin@126.com')
    assert_equal(user.gender,'female')
    assert_equal(user.provider,'facebook')
  end

  def test_get_facebook_user_invalid
    user=User.get_facebook_user('5423673443')
    assert_nil(user)
  end

end
