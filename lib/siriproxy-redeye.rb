require 'uri'
require 'cora'
require 'httparty'
require 'rubygems'
require 'siri_objects'

class SiriProxy::Plugin::RedEye < SiriProxy::Plugin
  attr_accessor :reip1
  attr_accessor :reip2
  
  def initialize(config)
    self.reip1 = config["reip1"]
    self.reip2 = config["reip2"]
    @reUrl1 = "#{self.reip1}:8080/redeye/rooms/0/devices/2/commands/send?commandId="
    @reUrl2 = "#{self.reip2}:8080/redeye/rooms/0/devices/2/commands/send?commandId="

@cmdId = Hash.new
@cmdId["0"] = 3
@cmdId["1"] = 4
@cmdId["2"] = 5
@cmdId["3"] = 6
@cmdId["4"] = 7
@cmdId["5"] = 8
@cmdId["6"] = 9
@cmdId["7"] = 10
@cmdId["8"] = 11
@cmdId["9"] = 12
@cmdId["channel up"] = 18
@cmdId["channel down"] = 19
@cmdId["enter"] = 14
@cmdId["info"] = 13
@cmdId["language"] = 21
@cmdId["last"] = 15
@cmdId["mute"] = 20
@cmdId["volume up"] = 16
@cmdId["volume down"] = 17

@stationId = Hash.new
@stationId["nbc"] = 3
@stationId["cbs"] = 9
@stationId["abc"] = 10
@stationId["fox"] = 11
@stationId["css"] = 32
@stationId["espn"] = 33
@stationId["espn2"] = 34
@stationId["sun sports"] = 35
@stationId["golf channel"] = 36
@stationId["fox sports"] = 37
@stationId["cnbc"] = 43
@stationId["foxnews"] = 44
@stationId["fox news"] = 44
@stationId["weather channel"] = 58

  end

  class Rest
    include HTTParty
    format :xml
  end


  listen_for(/channel ([0-9,]*[0-9])/i) do |number|
	change_channel number
  end
 
  listen_for(/station (.*)/i) do |station|
	change_station station
  end

  listen_for(/command (.*)/i) do |command|
	issue_command command
  end




  def change_channel(number)
	i = 0
	say "OK. Changing to channel #{number}."
	chan_str = number.to_s.split('')
	while i < chan_str.length do
		Rest.get("#{@reUrl2}#{@cmdId["#{chan_str[i]}"]}")
		sleep(1)
		i+=1
	end
	Rest.get("#{@reUrl2}#{@cmdId["enter"]}")
    request_completed
  end	

  def change_station(station)
	station = "#{station}".downcase
	station = "#{station}".rstrip
	number = "#{@stationId["#{station}"]}".to_i
	if number > 0
		change_channel number
	else
		say "Sorry, I can not find a station named #{station}."
	end
    request_completed
  end

  def issue_command(command)
	command = "#{command}".downcase
	command = "#{command}".rstrip
	commandid = "#{@cmdId["#{command}"]}".to_i
	if commandid > 0
		say "OK. Sending command #{command}."
		Rest.get("#{@reUrl2}#{commandid}")
	else
		say "Sorry, I am not programmed for command #{command}."
	end
    request_completed	
  end


end
