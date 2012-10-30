def configRedeye(config)

# Your RedEye unit URLs for controlling channels.
@reUrl = Hash.new
@reUrl["1"] = config["reip1"] + ":8080/redeye/rooms/0/devices/2/commands/send?commandId="
@reUrl["2"] = config["reip2"] + ":8080/redeye/rooms/0/devices/2/commands/send?commandId="

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

# Channel number and command syntax to actual RedEye device commandIds
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
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