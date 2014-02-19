require 'csv'
require 'date'
require './trip'
require './trip_collection'

tripfilename = "../data/Divvy_Trips_2013.csv"

triplist = []
trips = Array.new

dateformat = '%m/%d/%Y %H:%M'
options = { :headers => :first_row }

puts "Parsing #{tripfilename}..."

c = 0
CSV.foreach(tripfilename, options) do |row|
  trip = {}
  trip[:id] = row[0].to_i
  trip[:start_time] = DateTime.strptime(row[1], dateformat)
  trip[:end_time] = DateTime.strptime(row[2], dateformat)
  trip[:bike_id] = row[3].to_i
  trip[:duration] = row[4].delete(',').to_i
  trip[:start_id] = row[5] != "#N/A" ? row[5].to_i : 122
#  trip[:start_name] = row[6]
  trip[:end_id] = row[7] != "#N/A" ? row[7].to_i : 122
#  trip[:end_name] = row[8]
  trip[:user_type] = row[9]
  trip[:user_gender] = row[10]
  trip[:user_year] = row[11] != '' ? row[11].to_i : -1
#  triplist.push(trip)

  trips.push Trip.new(trip)

  print "#{c}... " if c%10000 == 0
  c+=1
end
puts "Done!"

trips_per_month = Hash.new(0) #{6=>0, 7=>0, 8=>0, 9=>0, 10=>0, 11=>0, 12=>0}
trips_per_gender = Hash.new(0) #{"Male" => 0, "Female" => 0}
trips_per_bike = Hash.new(0)

routes = {}


trips.each do |trip|
   trips_per_month[trip.start_time.month] += 1
   trips_per_gender[trip.user_gender] +=1 if trips_per_gender[trip.user_gender]
   trips_per_bike[trip.bike_id] += 1
   routes[trip.start_id] = Hash.new(0) unless routes[trip.start_id]
   routes[trip.start_id][trip.end_id] += 1
end

puts trips_per_month
puts trips_per_gender
puts trips_per_bike


female_trips = TripCollection.new(trips).trips_by_females()



#routes.each {|r| puts r}
