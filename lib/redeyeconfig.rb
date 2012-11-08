def configRedeye(config)

@reIp = Hash.new
@reIp = config["reips"]

@reFile = "#{Dir.home}/.siriproxy/resel"
if File.exists?(@reFile)
	@reSel = File.open(@reFile).first
else
	@reSel = "living room"
	File.open(@reFile, "w") {|f| f.write(@reSel)}
end

# URLs for multiple rooms for same RedEye.
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@roomId = Hash.new
@roomId["all"] = "/redeye/rooms/0"
@reRoom = "all"

# URLs for multiple devices for same RedEye.
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@deviceId = Hash.new { |h,k| h[k] = Hash.new }
@deviceId["all"]["cable box"] = "/devices/2"
@reDevice = "cable box"

# Channel number and command syntax to actual RedEye device commandIds
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@cmdId = Hash.new(&(p=lambda{|h,k| h[k] = Hash.new(&p)}))
@cmdId["all"]["cable box"]["0"] 		= "/commands/send?commandId=3"
@cmdId["all"]["cable box"]["zero"] 		= "/commands/send?commandId=3"
@cmdId["all"]["cable box"]["1"] 		= "/commands/send?commandId=4"
@cmdId["all"]["cable box"]["one"] 		= "/commands/send?commandId=4"
@cmdId["all"]["cable box"]["2"] 		= "/commands/send?commandId=5"
@cmdId["all"]["cable box"]["to"] 		= "/commands/send?commandId=5"
@cmdId["all"]["cable box"]["too"] 		= "/commands/send?commandId=5"
@cmdId["all"]["cable box"]["two"] 		= "/commands/send?commandId=5"
@cmdId["all"]["cable box"]["3"] 		= "/commands/send?commandId=6"
@cmdId["all"]["cable box"]["three"] 		= "/commands/send?commandId=6"
@cmdId["all"]["cable box"]["4"] 		= "/commands/send?commandId=7"
@cmdId["all"]["cable box"]["for"] 		= "/commands/send?commandId=7"
@cmdId["all"]["cable box"]["four"] 		= "/commands/send?commandId=7"
@cmdId["all"]["cable box"]["5"] 		= "/commands/send?commandId=8"
@cmdId["all"]["cable box"]["five"] 		= "/commands/send?commandId=8"
@cmdId["all"]["cable box"]["6"] 		= "/commands/send?commandId=9"
@cmdId["all"]["cable box"]["six"] 		= "/commands/send?commandId=9"
@cmdId["all"]["cable box"]["7"] 		= "/commands/send?commandId=10"
@cmdId["all"]["cable box"]["seven"] 		= "/commands/send?commandId=10"
@cmdId["all"]["cable box"]["8"] 		= "/commands/send?commandId=11"
@cmdId["all"]["cable box"]["ate"] 		= "/commands/send?commandId=11"
@cmdId["all"]["cable box"]["eight"] 		= "/commands/send?commandId=11"
@cmdId["all"]["cable box"]["9"] 		= "/commands/send?commandId=12"
@cmdId["all"]["cable box"]["nine"] 		= "/commands/send?commandId=12"
@cmdId["all"]["cable box"]["channel up"] 	= "/commands/send?commandId=18"
@cmdId["all"]["cable box"]["channel down"]	= "/commands/send?commandId=19"
@cmdId["all"]["cable box"]["enter"] 		= "/commands/send?commandId=14"
@cmdId["all"]["cable box"]["info"] 		= "/commands/send?commandId=13"
@cmdId["all"]["cable box"]["language"] 		= "/commands/send?commandId=21"
@cmdId["all"]["cable box"]["last"] 		= "/commands/send?commandId=15"
@cmdId["all"]["cable box"]["mute"] 		= "/commands/send?commandId=20"
@cmdId["all"]["cable box"]["volume up"] 	= "/commands/send?commandId=16"
@cmdId["all"]["cable box"]["volume down"] 	= "/commands/send?commandId=17"

# Station names to channel numbers.  
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@stationId = Hash.new
@stationId["nbc"] = 3
@stationId["cbs"] = 9
@stationId["abc"] = 10
@stationId["fox"] = 11
@stationId["css"] = 32
@stationId["espn"] = 33
@stationId["espn2"] = 34
@stationId["espn two"] = 34
@stationId["sun sports"] = 35
@stationId["son sports"] = 35
@stationId["golf channel"] = 36
@stationId["fox sports"] = 37
@stationId["cnbc"] = 43
@stationId["foxnews"] = 44
@stationId["fox news"] = 44
@stationId["weather channel"] = 58

end