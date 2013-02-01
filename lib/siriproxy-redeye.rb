require 'httparty'
require 'csv'
require 'redeyeconfig'

class SiriProxy::Plugin::RedEye < SiriProxy::Plugin
  attr_accessor :reips
  
  def initialize(config = {})
	configRedeye(config)
  end

  class Rest
    include HTTParty
    format :xml
  end


  listen_for(/channel ([0-9,]*[0-9](.*[0-9])?)/i) do |number|  
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

  listen_for(/room (.*)/i) do |room|
	change_room room
  end

  listen_for(/device (.*)/i) do |device|
	change_device device
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
    request_completed
  end	

  def change_station(station)
	number = @stationId[@reSel["feed"]][station.downcase.strip]
	unless number.nil?
		change_channel number
	else
		say "Sorry, I can not find a station named #{station}."
	end
    request_completed
  end

  def send_command(command)
	commandid = @cmdId[@reSel["room"]][@reSel["device"]][command.downcase.strip]
	unless commandid.empty?
		say "OK. Sending command #{command}."
		Rest.get(@cmdUrl + commandid)
	else
		say "Sorry, I am not programmed for command #{command}."
	end
    request_completed	
  end


  def change_redeye(redeye)
	unless @reIp[redeye.downcase.strip].nil?
		say "OK. Changing to RedEye #{redeye}."
		@reSel["redeye"] = redeye.downcase.strip
		room = ask "Which room would you like to control?" 
		change_room room
	else
		say "Sorry, I am not programmed to control RedEye #{redeye}."
	end
    request_completed	
  end

  def change_room(room)
	unless @roomId[room.downcase.strip].nil?
		say "OK. Changing to room #{room}."
		@reSel["room"] = room.downcase.strip
		device = ask "Which device would you like to control?" 
		change_device device
	else
		say "Sorry, I am not programmed to control room #{room}."
	end
    request_completed	
  end

  def change_device(device)
	unless @deviceId[@reSel["room"]][device.downcase.strip].nil?
		say "OK. Changing to device #{device}."
		@reSel["device"] = device.downcase.strip
		write_resel
	else
		say "Sorry, I am not programmed to control device #{device}."
	end
    request_completed	
  end

  def write_resel
	CSV.open(@reFile, "wb") {|csv| @reSel.to_a.each {|elem| csv << elem} }
	@cmdUrl = @reIp[@reSel["redeye"]] + @roomId[@reSel["room"]] + @deviceId[@reSel["room"]][@reSel["device"]] + "/commands/send?commandId="
  end


end
