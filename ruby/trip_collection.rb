require './trip'


class TripCollection
  DATA_YEAR = 2013

  def initialize(trips = {})
    @trips = trips
  end

  def trips()
    return @trips
  end

  def add(trip)
    @trips[trip.id] = trip
  end

  def get_trip(trip_id)
    @trips[trip_id]
  end

  def get_trips(trip_ids)
    TripCollection.new( trip_ids.map {|id, trip| {id => @trips[id]} } )
  end

  #--- Bike ID -----
  def trips_by_bike(id)
    TripCollection.new( @trips.select {|k, t| t.bike_id == id} )
  end
  def trips_by_bike!(id) 
    @trips.select! {|k, t| t.bike_id == id}
  end
  def all_trips_by_bike()
    trips = Hash.new()
    @trips.each do |id, trip| 
      trips[trip.bike_id] = TripCollection.new unless trips[trip.bike_id]
      trips[trip.bike_id].add(trip)
    end
    return trips
  end

  #--- Station ID ---
  def trips_by_start_id(id)
    TripCollection.new( @trips.select {|k, t| t.start_id==id} )
  end
  def trips_by_end_id(id)
    TripCollection.new( @trips.select {|k, t| t.end_id == id} )
  end
  def all_trips_by_start_id()
    trips = Hash.new()
    @trips.each do |id, trip|
      trips[trip.start_id] = TripCollection.new unless trips[trip.start_id]
      trips[trip.start_id].add(trip)
    end
    return trips
  end
  def all_trips_by_end_id()
    trips = Hash.new()
    @trips.each do |id, trip|
      trips[trip.end_id] = TripCollection.new unless trips[trip.end_id]
      trips[trip.end_id].add(trip)
    end
    return trips
  end

  #--- Month -----
  def trips_by_month(month)
    TripCollection.new( @trips.select {|k, t| t.start_time.month == month } )
  end
  def trips_by_month!(month)
    @trips.select! {|k, t| t.start_time.month == month }
  end
  def all_trips_by_month()
    trips = Hash.new()
    @trips.each do |id, trip|
      trips[trip.start_time.month] = TripCollection.new unless trips[trip.start_time.month]
      trips[trip.start_time.month].add(trip)
    end
    return trips
  end

  #--- Day of the week -----
  def trips_by_weekday()
    TripCollection.new( @trips.select {|k, t| t.start_time.wday.between?(1,5) } )
  end
  def trips_by_weekday!()
    @trips.select! {|k, t| t.start_time.wday.between?(1,5) }
  end
  def trips_by_weekend()
    TripCollection.new( @trips.select {|k, t| !t.start_time.wday.between?(1,5) } )
  end
  def trips_by_weekend!()
    @trips.select! {|k, t| !t.start_time.wday.between?(1,5) }
  end
  def all_trips_by_weekday()
    trips = Hash.new()
    @trips.each do |id, trip|
      trips[trip.start_time.wday] = TripCollection.new unless trips[trip.start_time.wday]
      trips[trip.start_time.wday].add(trip)
    end
    return trips
  end

  #--- Hour ---
  def trips_by_hour_range(start, stop)
    TripCollection.new( @trips.select {|k, t| t.start_time.hour.between?(start,stop) } )
  end
  def trips_by_hour_range!(start, stop)
    @trips.select! {|k, t| t.start_time.hour.between?(start,stop) }
  end
  def all_trips_by_hour()
    trips = Hash.new()
    @trips.each do |id, trip|
      trips[trip.start_time.hour] = TripCollection.new unless trips[trip.start_time.hour]
      trips[trip.start_time.hour].add(trip)
    end
    return trips
  end

  def trips_by_commuting_hours()
    TripCollection.new( @trips.select {|k,t| t.start_time.hour.between?(7,9) || t.start_time.hour.between?(4,6)} )
  end

  #--- Subscribers --
  def trips_by_subscribers()
    TripCollection.new( @trips.select {|k, t| t.user_type == "Subscriber"} )
  end
  def trips_by_subscribers!()
    @trips.select! {|k, t| t.user_type == "Subscriber"}
  end

  #--- Day Passes --
  def trips_by_customers()
    TripCollection.new( @trips.select {|k, t| t.user_type == "Customer"} )
  end
  def trips_by_customers!()
    @trips.select! {|k, t| t.user_type == "Customer"}
  end

  #--- Age
  def trips_by_birth_year(year)
    TripCollection.new( @trips.select {|k, t| t.user_year == year} )
  end 
  def trips_by_birth_year!(year)
    @trips.select! {|k, t| t.user_year == year}
  end
  def trips_by_age(age)
    year = DATA_YEAR - age
    trips_by_birth_year(year)
  end
  def trips_by_age!(age)
    year = DATA_YEAR - age
    trips_by_birth_year!(year) 
  end
  def all_trips_by_birth_year()
    trips = Hash.new()
    @trips.each do |id, trip|
      next unless trip.user_year
      trips[trip.user_year] = TripCollection.new unless trips[trip.user_year]
      trips[trip.user_year].add(trip)
    end
    return trips
  end
  def all_trips_by_age()
    trips = Hash.new()
    @trips.each do |id, trip|
      next unless trip.user_year
      age = DATA_YEAR - trip.user_year
      trips[age] = TripCollection.new unless trips[age]
      trips[age].add(trip)
    end
    return trips
  end
  
  #--- Gender --- 
  def trips_by_males()
    TripCollection.new( @trips.select {|k, t| t.user_gender == "Male" } )
  end
  def trips_by_males!()
    @trips.select! {|k, t| t.user_gender == "Male" }
  end
  def trips_by_females()
    TripCollection.new( @trips.select {|k, t| t.user_gender == "Female" } )
  end 
  def trips_by_females!()
    @trips.select! {|k, t| t.user_gender == "Female" }
  end
  def all_trips_by_gender()
    trips = Hash.new()
    @trips.each do |id, trip|
      next unless trip.user_gender
      trips[trip.user_gender] = TripCollection.new unless trips[trip.user_gender]
      trips[trip.user_gender].add(trip)
    end
    return trips
  end

  
end
