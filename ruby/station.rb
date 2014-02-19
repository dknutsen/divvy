
class Station
  attr_accessor :id, :name, :capacity, :lat, :long, :address1, :address2, 
                :landmark, :routes

  def initialize()

  end

  def to_s(verbose = false)
    return "#{@id}: #{@name}" + verbose ? " #{@lat},#{@long}" : ""
  end
end


