require 'test_helper'

class FreerangeTest < ActiveSupport::TestCase
   test "has_owner(user)" do
     assert( freeranges(:one).has_owner(users(:four)) )
	 assert_not( freeranges(:one).has_owner(users(:one)) )
     assert( freeranges(:two).has_owner(users(:one)) )
	 assert_not( freeranges(:two).has_owner(users(:four)) )
   end
  
  test "get_all_free_dates(user)" do
      ans1 = Set.new [DateTime.new(2013, 12, 11), DateTime.new(2013, 12, 12), DateTime.new(2013, 12, 13), DateTime.new(2013, 12, 24), DateTime.new(2013, 12, 25)]
      ans2 = Set.new []
	  ans3 = Set.new [DateTime.new(2013, 12, 28), DateTime.new(2013, 12, 29)]
	  ans4 = Set.new [DateTime.new(2013, 12, 10), DateTime.new(2013, 12, 11), DateTime.new(2013, 12, 12), DateTime.new(2013, 12, 13)]
	  assert_equal(Freerange.get_all_free_dates(users(:one)), ans1 )
      assert_equal(Freerange.get_all_free_dates(users(:two)), ans2)
      assert_equal(Freerange.get_all_free_dates(users(:three)), ans3)
      assert_equal(Freerange.get_all_free_dates(users(:four)), ans4 )
  end

  test "is_free_during(input_start_date,input_end_date,user)" do
      assert_not( Freerange.is_free_during(DateTime.new(2013, 12, 11), DateTime.new(2013, 12, 10), users(:one)))
      assert(Freerange.is_free_during(DateTime.new(2013, 12, 11), DateTime.new(2013, 12, 15), users(:one)) )
	  assert(Freerange.is_free_during(DateTime.new(2013, 12, 12), DateTime.new(2013, 12, 15), users(:one)) )
	  assert_not(Freerange.is_free_during(DateTime.new(2013, 12, 10), DateTime.new(2013, 12, 15), users(:one)) , "passed")
	  assert_not(Freerange.is_free_during(DateTime.new(2013, 12, 11), DateTime.new(2013, 12, 11), users(:two)) , "passed")
	  assert(Freerange.is_free_during(DateTime.new(2013, 12, 28), DateTime.new(2013, 12, 29), users(:three)), "passed" )
	  assert_not(Freerange.is_free_during(DateTime.new(2013, 12, 28), DateTime.new(2013, 12, 30), users(:three)), "passed" )
  end
end
