require 'dnssd'
require 'socket'
require 'httparty'
require 'yaml'

class SiriProxy::Plugin::RedEye < SiriProxy::Plugin

  class Rest
    include HTTParty
    format :xml
  end

############# Initialization
   
  @@reIP = Hash.new
  DNSSD.browse '_tf_redeye._tcp.' do |reply|
	puts "[Info - RedEye] Bonjour discovery: " + reply.name  
	addr = Socket.getaddrinfo(reply.name + ".local.", nil, Socket::AF_INET)
	@@reIP[reply.name] = addr[0][2]
  end

  begin
	@@Default = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reDefault.yml")))
  	@@stationID = 	YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reStation.yml")))
  rescue
  	puts "[Warning - RedEye] Error reading reDefault.yml and/or reStation.yml file."
  end
  
  begin
  	@@reSel = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reSel.yml")))
  	@@redeyeIP = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reRedeye.yml")))
  	@@roomID = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reRoom.yml")))
  	@@deviceID = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reDevice.yml")))
  	@@activityID = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reActivity.yml")))
  	@@commandID = YAML.load(File.read(File.expand_path(File.dirname( __FILE__ ) + "/reCommand.yml")))
	@@cmdURL = @@redeyeIP[@@reSel["redeye"]] + @@roomID[@@reSel["redeye"]][@@reSel["room"]] + @@deviceID[@@reSel["room"]][@@reSel["device"]]
  rescue
	@@reSel = @@Default	
	@@redeyeIP = Hash.new
   	@@roomID = Hash.new { |h,k| h[k] = Hash.new }
	@@deviceID = Hash.new { |h,k| h[k] = Hash.new }
	@@activityID = Hash.new { |h,k| h[k] = Hash.new }
  	@@commandID = Hash.new(&(p=lambda{|h,k| h[k] = Hash.new(&p)}))
	puts "[Warning - RedEye] Plugin not initialized. Say RedEye Initialize."
  end
   
  def initialize(config)
	# Unfortunately, anything put here gets run during SiriProxy >= 0.4.2 startup.
  end

############# Commands
  
  listen_for(/redeye initialize/i) do
	say "One moment while I initialize RedEye plugin..."
	Thread.new {
		init_redeyes
		update_resel
		say "SiriProxy RedEye plugin initialized."
		request_completed
	}		
  end

  listen_for(/channel ([0-9,]*[0-9](.*[0-9])?)/i) do |number|  
	change_channel number
	request_completed		
  end
 
  listen_for(/station (.*)/i) do |station|
	change_station station.downcase.strip
	request_completed		
  end

  listen_for(/activity (.*)/i) do |activity|
	launch_activity(@@reSel["room"], activity.downcase.strip)
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
	change_room(@@reSel["redeye"], room.downcase.strip)
	request_completed		
  end

  listen_for(/device (.*)/i) do |device|
	change_device(@@reSel["room"], device.downcase.strip)
	request_completed		
  end

  listen_for(/feed (.*)/i) do |feed|
	change_feed feed.downcase.strip
	request_completed		
  end

############# Actions

  def change_channel(number)
	i = 0
	say "Changing to channel #{number}."
	channelno = number.to_s.split('')
	while i < channelno.length do
		Rest.get(@@cmdURL + @@commandID[@@reSel["room"]][@@reSel["device"]][channelno[i]])
		sleep(0.2)
		i+=1
	end
  end	

  def change_station(station)
	number = @@stationID[@@reSel["feed"]][station]
	unless number.nil?
		change_channel number
	else
		say "Sorry, I can not find a station named #{station}."
	end
  end

  def launch_activity(room, activity)
	activityid = @@activityID[room][activity]
	unless activityid.nil?
		say "OK. Launching activity #{activity}."
		Rest.get(@@cmdURL + activityid)
	else
		say "Sorry, I am not programmed for activity #{activity}."
		say "Here is the list of activities in room #{room}."
		@@activityID[room].each_key {|activity| say activity}
		activity = ask "Which activity would you like to launch?"  
		launch_activity(room, activity.downcase.strip)
	end
  end

  def send_command(command)
	commandid = @@commandID[@@reSel["room"]][@@reSel["device"]][command]
	unless commandid.nil?
		say "Sending command #{command}."
		Rest.get(@@cmdURL + commandid)
	else
		say "Sorry, I am not programmed for command #{command}."
	end
  end

  def change_redeye(redeye)
	unless @@redeyeIP[redeye].nil?
		say "Changing to RedEye #{redeye}."
		@@reSel["redeye"] = redeye
		if @@roomID[redeye].length == 1
			change_room(redeye, @@roomID[redeye].keys[0])
		else
			room = ask "Which room would you like to control?" 
			change_room(redeye, room.downcase.strip)
		end
	else
		say "Sorry, I am not programmed to control RedEye #{redeye}."
		say "Here is the list of RedEyes."
		@@redeyeIP.each_key {|redeye| say redeye}
		redeye = ask "Which RedEye would you like to control?"  
		change_redeye(redeye.downcase.strip)
	end
  end

  def change_room(redeye, room)
	unless @@roomID[redeye][room].nil?
		say "Changing to room #{room}."
		@@reSel["room"] = room
		if @@deviceID[room].length == 1
			change_device(room, @@deviceID[room].keys[0])
		else
			device = ask "Which device would you like to control?" 
			change_device(room, device.downcase.strip)
		end
	else
		say "Sorry, I am not programmed to control room #{room}."
		say "Here is a list of rooms in RedEye #{redeye}"
		@@roomID[redeye].each_key {|room| say room}
		room = ask "Which room would you like to control?"  
		change_room(redeye, room.downcase.strip)
	end
  end

  def change_device(room, device)
	unless @@deviceID[room][device].nil?
		say "Changing to device #{device}."
		@@reSel["device"] = device
		update_resel
	else
		say "Sorry, I am not programmed to control device #{device}."
		say "Here is a list of devices in room #{room}."
		@@deviceID[room].each_key {|device| say device}
		device = ask "Which device would you like to control?"  
		change_device(room, device.downcase.strip)
	end
  end

  def change_feed(feed)
	if @@stationID.has_key?(feed)
		say "Changing to feed #{feed}."
		@@reSel["feed"] = feed
		update_resel
	else
		say "Sorry, I am not programmed for feed #{feed}."
	end
  end

############# Remember

  def update_resel
	File.write(File.expand_path(File.dirname( __FILE__ )) + "/reSel.yml", YAML.dump(@@reSel))
	@@cmdURL = @@redeyeIP[@@reSel["redeye"]] + @@roomID[@@reSel["redeye"]][@@reSel["room"]] + @@deviceID[@@reSel["room"]][@@reSel["device"]]
  end
		  		
############# Initialization
  
  def init_redeyes
  	@@reIP.each do |key, address|
 		puts "[Info - RedEye] Initializing: " + key
 		redeye = Rest.get("http://" + address.downcase + ":8080/redeye/").parsed_response["redeye"]
 		unless redeye.nil?
 			@@redeyeIP[redeye["name"].downcase.strip] = "http://" + address + ":8080/redeye" 
 	  		init_rooms(redeye["name"].downcase.strip)
 		end
	end
	
	begin
		File.write(File.expand_path(File.dirname( __FILE__ )) + "/reRedeye.yml", YAML.dump(@@redeyeIP))
		File.write(File.expand_path(File.dirname( __FILE__ )) + "/reRoom.yml", YAML.dump(@@roomID))
		File.write(File.expand_path(File.dirname( __FILE__ )) + "/reDevice.yml", YAML.dump(@@deviceID))
		File.write(File.expand_path(File.dirname( __FILE__ )) + "/reActivity.yml", YAML.dump(@@activityID))
		File.write(File.expand_path(File.dirname( __FILE__ )) + "/reCommand.yml", YAML.dump(@@commandID))
	rescue
		puts "[Warning - RedEye] Error caching RedEye configuration files."
	end
 end		
 		
  def init_rooms(redeye)
  	rooms = Rest.get(@@redeyeIP[redeye] + "/rooms/").parsed_response["rooms"]
  	unless rooms.nil?
		case rooms["room"]
		when Array
			rooms["room"].each do |room|
#				puts room 
				if room["roomId"].to_i != -1 
					@@roomID[redeye][room["name"].downcase.strip] = "/rooms/" + room["roomId"]
#					puts @@roomID
					init_devices(redeye, room["name"].downcase.strip)
					init_activities(redeye, room["name"].downcase.strip)
				end 
			end
		else
			room = rooms["room"]
#			puts room
			if room["roomId"].to_i != -1 
				@@roomID[redeye][room["name"].downcase.strip] = "/rooms/" + room["roomId"]
#				puts @@roomID
				init_devices(redeye, room["name"].downcase.strip)
				init_activities(redeye, room["name"].downcase.strip)
			end
		end
	end
  end
  
  def init_devices(redeye, room)	
	devices = Rest.get(@@redeyeIP[redeye] + @@roomID[redeye][room] + "/devices/").parsed_response["devices"]
	unless devices.nil?
		case devices["device"]
		when Array
			devices["device"].each do |device|
#				puts device
				@@deviceID[room][device["displayName"].downcase.strip] = "/devices/" + device["deviceId"] 
#				puts @@deviceID
				init_commands(redeye, room, device["displayName"].downcase.strip)
			end
		else
			device = devices["device"]
#			puts device
			@@deviceID[room][device["displayName"].downcase.strip] = "/devices/" + device["deviceId"] 
#			puts @@deviceID
			init_commands(redeye, room, device["displayName"].downcase.strip)
		end
	end
  end
  
  def init_activities(redeye, room)	
	activities = Rest.get(@@redeyeIP[redeye] + @@roomID[redeye][room] + "/activities/").parsed_response["activities"]
	unless activities.nil?
		case activities["activity"]
		when Array
			activities["activity"].each do |activity|
#				puts activity
				@@activityID[room][activity["name"].downcase.strip] = "/activities/" + activity["activityId"] 
#				puts @@activityID
			end
		else
			activity = activities["activity"]
#			puts activity
			@@activityID[room][activity["name"].downcase.strip] = "/activities/" + activity["activityId"] 
#			puts @@activityID
		end
	end
  end
  
  def init_commands(redeye, room, device)
  	commands = Rest.get(@@redeyeIP[redeye] + @@roomID[redeye][room] + @@deviceID[room][device] + "/commands/").parsed_response["commands"]
  	unless commands.nil?
  		case commands["command"]
  		when Array
  			commands["command"].each do |command|
#  				puts command
  				@@commandID[room][device][command["name"].downcase.strip] = "/commands/send?commandId=" + command["commandId"]
#  				puts @@commandID
  			end
  		else
  			command = commands["command"]
#  			puts command
  			@@commandID[room][device][command["name"].downcase.strip] = "/commands/send?commandId=" + command["commandId"]
#  			puts @@commandID
  		end
  	end	
  end
  

			
end
