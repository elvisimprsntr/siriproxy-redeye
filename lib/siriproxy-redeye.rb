require 'httparty'
require 'csv'
require 'redeyeconfig'

class SiriProxy::Plugin::RedEye < SiriProxy::Plugin
  attr_accessor :reips
  
  def initialize(config = {})
	@reIp = Hash.new
	@reIp = config["reips"]
	
	configRedeye(config)
  end

  class Rest
    include HTTParty
    format :xml
  end


  listen_for(/channel ([0-9,]*[0-9](.*[0-9])?)/i) do |number|  
	change_channel number
    request_completed		
  end
 
  listen_for(/station (.*)/i) do |station|
	change_station station.downcase.strip
    request_completed		
  end

  listen_for(/command (.*)/i) do |command|
	send_command command.downcase.strip
    request_completed		
  end

  listen_for(/redeye (.*)/i) do |redeye|
	change_redeye redeye.downcase.strip
    request_completed		
  end

  listen_for(/room (.*)/i) do |room|
	change_room room.downcase.strip
    request_completed		
  end

  listen_for(/device (.*)/i) do |device|
	change_device device.downcase.strip
    request_completed		
  end

  def change_channel(number)
	i = 0
	say "OK. Changing to channel #{number}."
	channelno = number.to_s.split('')
	while i < channelno.length do
		Rest.get(@cmdUrl + @cmdId[@reSel["room"]][@reSel["device"]][channelno[i]])
		sleep(0.2)
		i+=1
	end
  end	

  def change_station(station)
	number = @stationId[@reSel["feed"]][station]
	unless number.nil?
		change_channel number
	else
		say "Sorry, I can not find a station named #{station}."
	end
  end

  def send_command(command)
	commandid = @cmdId[@reSel["room"]][@reSel["device"]][command]
	unless commandid.empty?
		say "OK. Sending command #{command}."
		Rest.get(@cmdUrl + commandid)
	else
		say "Sorry, I am not programmed for command #{command}."
	end
  end


  def change_redeye(redeye)
	unless @reIp[redeye].nil?
		say "OK. Changing to RedEye #{redeye}."
		@reSel["redeye"] = redeye
		room = ask "Which room would you like to control?" 
		change_room room.downcase.strip
	else
		say "Sorry, I am not programmed to control RedEye #{redeye}."
	end
  end

  def change_room(room)
	unless @roomId[room].nil?
		say "OK. Changing to room #{room}."
		@reSel["room"] = room
		device = ask "Which device would you like to control?" 
		change_device device.downcase.strip
	else
		say "Sorry, I am not programmed to control room #{room}."
	end
  end

  def change_device(device)
	unless @deviceId[@reSel["room"]][device].nil?
		say "OK. Changing to device #{device}."
		@reSel["device"] = device
		write_resel
	else
		say "Sorry, I am not programmed to control device #{device}."
	end
  end

  def write_resel
	CSV.open(@reFile, "wb") {|csv| @reSel.to_a.each {|elem| csv << elem} }
	@cmdUrl = @reIp[@reSel["redeye"]] + @roomId[@reSel["room"]] + @deviceId[@reSel["room"]][@reSel["device"]] + "/commands/send?commandId="
  end


end
