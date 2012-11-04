def configRedeye(config)

@reIp = Hash.new
@reIp = config["reips"]

@reFile = "#{Dir.home}/.siriproxy/resel"
if File.exists?(@reFile)
	@reSel = File.open(@reFile).first
else
	@reSel = 2
	File.open(@reFile, 'w') {|f| f.write(@reSel)}
end

# What ever you want to call your RedEye units if you have more than one.  The assignment above will be the default.
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
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

# URLs for multiple rooms for same RedEye.
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@roomId = Hash.new
@roomId["all"] = "/redeye/rooms/0"
@reRoom = "all"

# URLs for multiple devices for same RedEye.
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@deviceId = Hash.new
@deviceId["cable box"] = "/devices/2"
@reDevice = "cable box"

# Channel number and command syntax to actual RedEye device commandIds
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@cmdId = Hash.new
@cmdId["0"] 		= "/commands/send?commandId=3"
@cmdId["zero"] 		= "/commands/send?commandId=3"
@cmdId["1"] 		= "/commands/send?commandId=4"
@cmdId["one"] 		= "/commands/send?commandId=4"
@cmdId["2"] 		= "/commands/send?commandId=5"
@cmdId["to"] 		= "/commands/send?commandId=5"
@cmdId["too"] 		= "/commands/send?commandId=5"
@cmdId["two"] 		= "/commands/send?commandId=5"
@cmdId["3"] 		= "/commands/send?commandId=6"
@cmdId["three"] 	= "/commands/send?commandId=6"
@cmdId["4"] 		= "/commands/send?commandId=7"
@cmdId["for"] 		= "/commands/send?commandId=7"
@cmdId["four"] 		= "/commands/send?commandId=7"
@cmdId["5"] 		= "/commands/send?commandId=8"
@cmdId["five"] 		= "/commands/send?commandId=8"
@cmdId["6"] 		= "/commands/send?commandId=9"
@cmdId["six"] 		= "/commands/send?commandId=9"
@cmdId["7"] 		= "/commands/send?commandId=10"
@cmdId["seven"] 	= "/commands/send?commandId=10"
@cmdId["8"] 		= "/commands/send?commandId=11"
@cmdId["ate"] 		= "/commands/send?commandId=11"
@cmdId["eight"] 	= "/commands/send?commandId=11"
@cmdId["9"] 		= "/commands/send?commandId=12"
@cmdId["nine"] 		= "/commands/send?commandId=12"
@cmdId["channel up"] 	= "/commands/send?commandId=18"
@cmdId["channel down"] = "/commands/send?commandId=19"
@cmdId["enter"] 	= "/commands/send?commandId=14"
@cmdId["info"] 		= "/commands/send?commandId=13"
@cmdId["language"] 	= "/commands/send?commandId=21"
@cmdId["last"] 		= "/commands/send?commandId=15"
@cmdId["mute"] 		= "/commands/send?commandId=20"
@cmdId["volume up"] 	= "/commands/send?commandId=16"
@cmdId["volume down"] 	= "/commands/send?commandId=17"

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