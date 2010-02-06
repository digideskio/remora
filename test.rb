require 'client'
require 'mplayer'
require 'dbus-interface'

client = GrooveShark::Client.new
$session = client.session
puts "Session is #{client.session}"
puts "Communication token is #{client.comm_token}"
puts "Queue is #{client.queue} (#{client.queue.id})"

run_dbus client

puts "Searching for 'honky tonk':"
results = client.search_songs('honky tonk')['Return']
results.each do |result|
  puts "#{results.index result} - #{result['Name']} - #{result['ArtistName']} - #{result['AlbumName']}"
end

puts
puts "Please type in a song index to [attempt to] play it:"
index = gets.to_i

client.queue << results[index]
client.queue.play_radio
