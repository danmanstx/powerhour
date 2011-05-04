#!/usr/local/bin/macruby

require 'osx/cocoa'

include OSX

OSX.require_framework 'ScriptingBridge'


name_of_playlist = "depression vol 2"

#framework 'Foundation'
#framework 'ScriptingBridge'

puts "enter number of players:"
numplayers = gets.chomp


numplayer = numplayers.to_i
i = 0
$weight = [numplayer]
$bac    = [numplayer]
$name   = [numplayer]
$sex    = [numplayer]

while i < numplayer
  real_num = i + 1
  puts "enter name for player #{real_num} :"
  weighttemp = gets.chomp
  $name[i] = weighttemp
  i = i + 1
end

i = 0

while i < numplayer
  real_num = 1 + i
  puts "enter weight for player #{real_num} :"
  weighttemp = gets.chomp
  $weight[i] = weighttemp.to_i
  i = i + 1
end
i = 0
while i < numplayer
  real_num = i + 1
  puts "enter sex for player #{real_num} (1 for male, 2 for female):"
  weighttemp = gets.chomp
  $sex[i] = weighttemp.to_i
  i = i + 1
end

$time = 0;

#def bac_calc(time, numplayer, @weight, @bac)
#counter = 0 
#while counter < numplayer
#  bac[counter] = ( 60 * ( 5.14 / weight[i]) * 0.73) - (time * 0.015)
#  counter = counter + 1
#end
#end

def bac_calc( time, sex, weight)
  if sex == 1
    coef = 0.73
  else
    coef = 0.66
  end
  bac = (( (time * 1.5 * 0.05) * (5.14 / weight) * coef ) - ((time/60) * 0.015) )
  return bac
end

itunes = SBApplication.applicationWithBundleIdentifier("com.apple.itunes")

itunes.run

playlist = itunes.sources.objectWithName("Library").userPlaylists.objectWithName(name_of_playlist)

first = 1

for x in 0..60
  if first == 1
    playlist.playOnce(false) if playlist
    puts "the First track is #{itunes.currentTrack().name()} by #{itunes.currentTrack().artist()}"
    first = 2
  else
    sleep(60)
    itunes.nextTrack()
    puts "the current track is #{itunes.currentTrack().name()} by #{itunes.currentTrack().artist()} this is track number #{$time+2}"
    counter = 0
    while counter < numplayer
      $bac[counter] = bac_calc($time, $sex[counter], $weight[counter])
      puts "BAC for #{$name[counter]} is #{$bac[counter]}"
      counter = counter + 1
    end
    $time = $time + 1
  end
end
