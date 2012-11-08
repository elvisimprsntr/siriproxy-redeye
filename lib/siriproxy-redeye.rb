require 'httparty'
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
		Rest.get(@reIp[@reSel] + @roomId[@reRoom] + @deviceId[@reRoom][@reDevice] + @cmdId[@reRoom][@reDevice][chan_str[i]])
		sleep(0.2)
		i+=1
	end
	Rest.get(@reIp[@reSel] + @roomId[@reRoom] + @deviceId[@reRoom][@reDevice] + @cmdId[@reRoom][@reDevice]["enter"])
    request_completed
  end	

  def change_station(station)
	number = @stationId[station.downcase.strip]
	unless number.nil?
		change_channel number
	else
		say "Sorry, I can not find a station named #{station}."
	end
    request_completed
  end

  def send_command(command)
	commandid = @cmdId[@reRoom][@reDevice][command.downcase.strip]
	unless commandid.nil?
		say "OK. Sending command #{command}."
		Rest.get(@reIp[@reSel] + @roomId[@reRoom] + @deviceId[@reRoom][@reDevice] + commandid)
	else
		say "Sorry, I am not programmed for command #{command}."
	end
    request_completed	
  end


  def change_redeye(redeye)
	unless @reIp[redeye.downcase.strip].nil?
		say "OK. Changing to RedEye #{redeye}."
		@reSel = redeye.downcase.strip
		File.open(@reFile, "w") {|f| f.write(@reSel)} 
	else
		say "Sorry, I am not programmed to control RedEye #{redeye}."
	end
    request_completed	
  end



end
