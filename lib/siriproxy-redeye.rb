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
    @reUrl = @reUrl2	

@redeyeId = Hash.new
@redeyeId["one"] = 1
@redeyeId["house"] = 1
@redeyeId["whole house"] = 1
@redeyeId["garage"] = 1
@redeyeId["bedroom"] = 1
@redeyeId["to"] = 2
@redeyeId["too"] = 2
@redeyeId["two"] = 2
@redeyeId["living"] = 2
@redeyeId["living room"] = 2

@cmdId = Hash.new
@cmdId["0"] = 3
@cmdId["zero"] = 3
@cmdId["1"] = 4
@cmdId["one"] = 4
@cmdId["2"] = 5
@cmdId["to"] = 5
@cmdId["too"] = 5
@cmdId["two"] = 5
@cmdId["3"] = 6
@cmdId["three"] = 6
@cmdId["4"] = 7
@cmdId["for"] = 7
@cmdId["four"] = 7
@cmdId["5"] = 8
@cmdId["five"] = 8
@cmdId["6"] = 9
@cmdId["six"] = 9
@cmdId["7"] = 10
@cmdId["seven"] = 10
@cmdId["8"] = 11
@cmdId["ate"] = 11
@cmdId["eight"] = 11
@cmdId["9"] = 12
@cmdId["nine"] = 12
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
	send_command command
  end

  listen_for(/redeye (.*)/i) do |redeye|
	change_redeye redeye
  end

  


  def change_channel(number)
	i = 0
	say "OK. Changing to channel #{number}."
	chan_str = number.to_s.split('')
	while i < chan_str.length do
		Rest.get("#{@reUrl}#{@cmdId["#{chan_str[i]}"]}")
		sleep(1)
		i+=1
	end
	Rest.get("#{@reUrl}#{@cmdId["enter"]}")
    request_completed
  end	

  def change_station(station)
	number = @stationId[station.downcase.strip].to_i
	if number > 0
		change_channel number
	else
		say "Sorry, I can not find a station named #{station}."
	end
    request_completed
  end

  def send_command(command)
	commandid = @cmdId[command.downcase.strip].to_i
	if commandid > 0
		say "OK. Sending command #{command}."
		Rest.get("#{@reUrl}#{commandid}")
	else
		say "Sorry, I am not programmed for command #{command}."
	end
    request_completed	
  end


  def change_redeye(redeye)
	redeyeid = @redeyeId[redeye.downcase.strip].to_i
	if redeyeid > 0
		say "OK. Changing to RedEye #{redeye}."
		@reUrl = instance_variable_get("@reUrl#{redeyeid}")
	else
		say "Sorry, I am not programmed to control RedEye #{redeye}."
	end
    request_completed	
  end



end
