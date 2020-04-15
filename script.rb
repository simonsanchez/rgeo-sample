require 'rgeo/geo_json'

def meters_to_miles(meters)
  miles = meters * 0.000621371
  miles.round(3)
end

geographic_factory = RGeo::Geographic.spherical_factory(srid: 4326)
berkeley_centroid = geographic_factory.point(-122.2989, 37.8665)
oakland_centroid = geographic_factory.point(-122.2244, 37.7695)
distance = berkeley_centroid.distance(oakland_centroid)
puts "Distance from Berkeley centroid to Oakland centroid: #{meters_to_miles(distance)} miles"
puts ""


mission_geojson = File.read('mission_district.json').strip
mission_geom = RGeo::GeoJSON.decode(mission_geojson).geometry

potrero_geojson = File.read('potrero.json').strip
potrero_geom = RGeo::GeoJSON.decode(potrero_geojson).geometry

intersection = mission_geom.intersection(potrero_geom)
intersection_geojson = RGeo::GeoJSON.encode(intersection).to_json
puts 'Intersection of the neighboorhoods Potrero and Mision District as GeoJSON:'
puts intersection_geojson
