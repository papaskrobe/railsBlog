module UsersHelper

  def all_time_zones
   ActiveSupport::TimeZone.all.collect { |x| [x.to_s, x.utc_offset] } 
  end

end
