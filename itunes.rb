#!/usr/local/bin/macruby

require 'osx/cocoa'

include OSX

OSX.require_framework 'ScriptingBridge'


name_of_playlist = "depression vol 2"

#framework 'Foundation'
#framework 'ScriptingBridge'



#i = 0
#bac = []

#puts "enter number of players"
#numplayers = gets.chomp

#counter = 0
#weight = []

#while i < numplayers.to_i
#  puts "weight for player"
#  weight[i] = gets.chomp
#  i = i + 1
#end

#i = 0

#  while counter < numplayers[i].to_i
#  bac[i] = ((60 * (5.14/ weight[i].to_f) * 0.73) - 0.015)
#  counter = counter + 1
#  i = i + 1
#  end


itunes = SBApplication.applicationWithBundleIdentifier("com.apple.itunes")

itunes.run



print itunes.currentTrack().name()

playlist = itunes.sources.objectWithName("Library").userPlaylists.objectWithName(name_of_playlist)

time1 = Time.new
time2 = time1 + 60
first = 1

for x in 0..60
  if first == 1
    playlist.playOnce(false) if playlist
  end
  sleep(60)
  first = 2
  itunes.nextTrack()
  #bac.each { |x| print x}
  
end
