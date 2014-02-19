require './station'
require 'open-uri'
require 'json'

class StationList

  def initialize()
    @stations = Hash.new
  end

  def stations
    @stations
  end

  def get_station(id)
    @stations[id]
  end

  def load_from_divvy_JSON()
    stations = JSON.load(open("http://divvybikes.com/stations/json/"))
    stations = stations["stationBeanList"]
    stations.each do |s|
      new = Station.new
      new.id = s["id"]
      new.name = s["stationName"]
      new.capacity = s["totalDocks"]
      new.lat = s["latitude"]
      new.long = s["longitude"]
      new.address1 = s["stAddress1"]
      new.address2 = s["stAddress2"]
      new.landmark = s["landmark"]
      @stations[new.id] = new
    end 
  end
end



