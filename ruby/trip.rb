
class Trip
  attr_accessor :id, :start_time, :end_time, :bike_id, :duration, 
                :start_id, :start_name, :end_id, :end_name, 
                :user_type, :user_gender, :user_year
  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
end


