require 'csv'
require 'date'
require './trip_collection'
require './station_list'

class DivvyData
  DATAFILE = "../data/Divvy_Trips_2013.csv"
  DATEFORMAT = '%m/%d/%Y %H:%M'

  #
  # @trips = TripCollection of all trips
  #
  # @stations = StationList of all stations


  def initialize()
    @trips = nil
    parse_data(DATAFILE)

    @stations = StationList.new
    @stations.load_from_divvy_JSON

    puts "Collecting all routes for stations... "
    @stations.stations.each do |k, s|
      print "#{k} "
      s.routes = @trips.trips_by_start_id(s.id).all_trips_by_end_id
    end
    puts "Done!"
    
  end

  def trips()
    return @trips
  end

  def stations()
    return @stations
  end




  private

  def parse_data(filename, options = { :headers => :first_row } )
    trips = Hash.new
    puts "Parsing #{filename}..."
    c = 0
    CSV.foreach(filename, options) do |row|
      trip = {}
      trip[:id] = row[0].to_i
      trip[:start_time] = DateTime.strptime(row[1], DATEFORMAT)
      trip[:end_time] = DateTime.strptime(row[2], DATEFORMAT)
      trip[:bike_id] = row[3].to_i
      trip[:duration] = row[4].delete(',').to_i
      trip[:start_id] = row[5] != "#N/A" ? row[5].to_i : 122
    #  trip[:start_name] = row[6]
      trip[:end_id] = row[7] != "#N/A" ? row[7].to_i : 122
    #  trip[:end_name] = row[8]
      trip[:user_type] = row[9]
      trip[:user_gender] = row[10]
      trip[:user_year] = row[11] != '' ? row[11].to_i : -1
      trips[trip[:id]] = Trip.new(trip)
      print "#{c}... " if c%10000 == 0
      c+=1
    end
    puts "Done!"
    @trips = TripCollection.new trips
  end
end
