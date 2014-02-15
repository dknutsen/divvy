import json
import urllib

def _decode_list(data):
   rv = []
   for item in data:
      if isinstance(item, unicode):
         item = item.encode('utf-8')
      elif isinstance(item, list):
         item = _decode_list(item)
      elif isinstance(item, dict):
         item = _decode_dict(item)
      rv.append(item)
   return rv

def _decode_dict(data):
   rv = {}
   for key, value in data.iteritems():
      if isinstance(key, unicode):
         key = key.encode('utf-8')
      if isinstance(value, unicode):
         value = value.encode('utf-8')
      elif isinstance(value, list):
         value = _decode_list(value)
      elif isinstance(value, dict):
         value = _decode_dict(value)
      rv[key] = value
   return rv



class DivvyStations:
   def __init__(self):
      jsonurl = urllib.urlopen('http://divvybikes.com/stations/json')
      data = json.loads(jsonurl.read(), object_hook=_decode_dict)
      slist = data["stationBeanList"]
      self.stationlist = {}
      for row in slist :
         self.stationlist[row["id"]] = row
 
   def get_station(self, station_id) :
      return self.stationlist[station_id]

   def to_s(self) :
      for station in self.stationlist :
         print station

