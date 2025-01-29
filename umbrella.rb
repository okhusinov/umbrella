require "http"
require "json"
require "dotenv/load"

puts "================================================"
puts "        Will you need an umbrella today?        "
puts "================================================"
puts ""
puts "Where are you? "
location = gets.chomp
puts "Checking the weather at #{location}...."
gmaps_api_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_api_key}"
raw_gmaps_response = HTTP.get(gmaps_url)
parsed_gmaps_response = JSON.parse(raw_gmaps_response)
latitude = parsed_gmaps_response.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
longitude = parsed_gmaps_response.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")
puts "Your coordinates are #{latitude}, #{longitude}."
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude.to_s}, #{longitude.to_s}"
raw_pirate_weather_response = HTTP.get(pirate_weather_url)
parsed_pirate_weather_response = JSON.parse(raw_pirate_weather_response)
current_temp = parsed_pirate_weather_response.fetch("currently").fetch("temperature")
puts "It is currently " + current_temp.to_s + "°F."
