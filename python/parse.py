import csv
from datetime import datetime, date, time

tripfilename = "Divvy_Trips_2013.csv"

triplist = []

def parse_datetime(s) :
   split = s.split(" ")
   date = split[0].split("/")
   time = split[1].split(":")
   return datetime(int(date[2]), int(date[0]), int(date[1]), int(time[0]), int(time[1]))



with open(tripfilename, 'rb') as csvfile :
   tripreader = csv.reader(csvfile)
   print tripreader.next()
   for row in tripreader:
      tripdict = {}
      tripdict["id"] = int(row[0])
      tripdict["start"] = parse_datetime(row[1])
      tripdict["end"] = parse_datetime(row[2])
      tripdict["bikeid"] = int(row[3])
      tripdict["duration"] = int(row[4].replace(',', ''))
      tripdict["startid"] = int(row[5]) if row[5] != "#N/A" else 122
      tripdict["startname"] = row[6]
      tripdict["endid"] = int(row[7]) if row[7] != "#N/A" else 122
      tripdict["endname"] = row[8]  
      tripdict["usertype"] = row[9]
      tripdict["usergender"] = row[10]
      tripdict["useryear"] = int(row[11]) if row[11] != '' else -1
      triplist.append(tripdict)
   print triplist[200000]

   print "trips made by users with birth year:"
   userages = {}
   for year in range(1900, 2000) :
      yearitems = [i["id"] for i in triplist if i["useryear"] == year]
      userages[year] = yearitems
      print str(year) + ":" + str(len(yearitems))

   print "trips per bike:"
   biketrips = {}
   for trip in triplist :
      if trip["bikeid"] not in biketrips :
         biketrips[trip["bikeid"]] = [] 
      biketrips[trip["bikeid"]].append(trip)
   for key in biketrips :
      print str(key) + ":" + str(len(biketrips[key]))
