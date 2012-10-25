require 'uri'
require 'cora'
require 'httparty'
require 'rubygems'
require 'siri_objects'

class SiriProxy::Plugin::RedEye < SiriProxy::Plugin
  attr_accessor :reipl1
  attr_accessor :reipl2
  
  def initialize(config)
    self.reip1 = config["reip1"]
    self.reip2 = config["reip2"]
  end

  class Rest
    include HTTParty
    format :xml
  end

reurl1 = "#{self.reip1}:8080/redeye/rooms/0/devices/2/commands/send?commandId="
reurl2 = "#{self.reip2}:8080/redeye/rooms/0/devices/2/commands/send?commandId="

cmdzero 	= "3"
cmdone 		= "4"
cmdtwo 		= "5"
cmdthree 	= "6"
cmdfour 	= "7"
cmdfive 	= "8"
cmdsix 		= "9"
cmdseven 	= "10"
cmdeight 	= "11"
cmdnine 	= "12"
cmdchup		= "18"
cmdchdn 	= "19"
cmdenter 	= "14"
cmdinfo 	= "13"
codlang 	= "21"
cmdlast 	= "15"
cmdmute 	= "17"
cmdvolup 	= "16"
cmdvoldn 	= "17"



listen_for(/CNBC/i) {cnbc}
listen_for(/ESPN/i) {espn}
listen_for(/weather channel/i) {twc}
listen_for(/nickelodeon/i) {nick}


  def cnbc
    say "OK. Changing the channel to CNBC."
    Rest.get("#{reurl2}#{cmdfour}")
    Rest.get("#{reurl2}#{cmdthree}")
    Rest.get("#{reurl2}#{cmdenter}")
    request_completed
  end

  def espn
    say "OK. Changing the channel to ESPN."
    Rest.get("#{reurl2}#{cmdthree}")
    Rest.get("#{reurl2}#{cmdthree}")
    Rest.get("#{reurl2}#{cmdenter}")
    request_completed
  end

  def twc
    say "OK. Changing the channel to The Weather Channel."
    Rest.get("#{reurl2}#{cmdfive}")
    Rest.get("#{reurl2}#{cmdeight}")
    Rest.get("#{reurl2}#{cmdenter}")
    request_completed
  end

  def nick
    say "OK. Changing the channel to Nickelodeon."
    Rest.get("#{reurl2}#{cmdsix}")
    Rest.get("#{reurl2}#{cmdone}")
    Rest.get("#{reurl2}#{cmdenter}")
    request_completed
  end



	
end
