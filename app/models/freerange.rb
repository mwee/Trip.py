class Freerange < ActiveRecord::Base
  belongs_to :user
  validates_date :start_date, :on_or_after => Time.now
  validates_date :end_date, :on_or_after => :start_date
  
  #return true if the user owns the free range
  def owns_range(user)
    return self.user.id==user.id
  end

  #return a set of free dates for a user.
  def self.get_all_free_dates(user)
    free_dates = Set.new []
    for range in user.freeranges
      start=range.start_date
      while !(start>range.end_date)
        free_dates.merge([start])
        start += 1
      end
    end
    return free_dates
  end

  #return a boolean indicating if the user is free during input_start_date to input_end_date
  def self.is_free_during(input_start_date,input_end_date,user)
    if !user.freeranges.any?
      return false
    end
    test_date=input_start_date
    all_free_dates=self.get_all_free_dates(user)
    while test_date <= input_end_date
      if (all_free_dates.member? test_date)
        return false
      end
      test_date += 1
    end
    return true
  end

end
