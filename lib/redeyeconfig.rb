def configRedeye(config)

# URLs for multiple rooms for same RedEye.
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@roomId = Hash.new
@roomId["living"] = "/redeye/rooms/0"
@roomId["house"] = "/redeye/rooms/0"

# URLs for multiple devices for same RedEye.
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@deviceId = Hash.new { |h,k| h[k] = Hash.new }
@deviceId["living"]["tv"] = "/devices/194"
@deviceId["house"]["dta"] = "/devices/140"

# Channel number and command syntax to actual RedEye device commandIds
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@cmdId = Hash.new(&(p=lambda{|h,k| h[k] = Hash.new(&p)}))
@cmdId["living"]["tv"]["."]		= "199"
@cmdId["living"]["tv"]["0"]		= "141"
@cmdId["living"]["tv"]["zero"] 	= "141"
@cmdId["living"]["tv"]["1"] 		= "138"
@cmdId["living"]["tv"]["one"] 		= "138"
@cmdId["living"]["tv"]["2"] 		= "181"
@cmdId["living"]["tv"]["to"] 		= "181"
@cmdId["living"]["tv"]["too"] 		= "181"
@cmdId["living"]["tv"]["two"] 		= "181"
@cmdId["living"]["tv"]["3"] 		= "185"
@cmdId["living"]["tv"]["three"] 	= "185"
@cmdId["living"]["tv"]["4"] 		= "189"
@cmdId["living"]["tv"]["for"] 		= "189"
@cmdId["living"]["tv"]["four"] 	= "189"
@cmdId["living"]["tv"]["5"] 		= "192"
@cmdId["living"]["tv"]["five"] 	= "192"
@cmdId["living"]["tv"]["6"] 		= "135"
@cmdId["living"]["tv"]["six"] 		= "135"
@cmdId["living"]["tv"]["7"] 		= "137"
@cmdId["living"]["tv"]["seven"] 	= "137"
@cmdId["living"]["tv"]["8"] 		= "11"
@cmdId["living"]["tv"]["ate"] 		= "11"
@cmdId["living"]["tv"]["eight"] 	= "11"
@cmdId["living"]["tv"]["9"] 		= "140"
@cmdId["living"]["tv"]["nine"] 	= "140"
@cmdId["living"]["tv"]["channel up"] 	= "187"
@cmdId["living"]["tv"]["channel down"] = "190"
@cmdId["living"]["tv"]["last"] 	= "136"
@cmdId["living"]["tv"]["mute"] 	= "134"
@cmdId["living"]["tv"]["volume up"] 	= "180"
@cmdId["living"]["tv"]["volume down"] = "184"
@cmdId["house"]["dta"]["."]		= "171"
@cmdId["house"]["dta"]["0"]		= "169"
@cmdId["house"]["dta"]["zero"] 	= "169"
@cmdId["house"]["dta"]["1"] 		= "159"
@cmdId["house"]["dta"]["one"] 		= "159"
@cmdId["house"]["dta"]["2"] 		= "160"
@cmdId["house"]["dta"]["to"] 		= "160"
@cmdId["house"]["dta"]["too"] 		= "160"
@cmdId["house"]["dta"]["two"] 		= "160"
@cmdId["house"]["dta"]["3"] 		= "162"
@cmdId["house"]["dta"]["three"] 	= "162"
@cmdId["house"]["dta"]["4"] 		= "163"
@cmdId["house"]["dta"]["for"] 		= "163"
@cmdId["house"]["dta"]["four"] 	= "163"
@cmdId["house"]["dta"]["5"] 		= "164"
@cmdId["house"]["dta"]["five"] 	= "164"
@cmdId["house"]["dta"]["6"] 		= "165"
@cmdId["house"]["dta"]["six"] 		= "165"
@cmdId["house"]["dta"]["7"] 		= "166"
@cmdId["house"]["dta"]["seven"] 	= "166"
@cmdId["house"]["dta"]["8"] 		= "167"
@cmdId["house"]["dta"]["ate"] 		= "167"
@cmdId["house"]["dta"]["eight"] 	= "167"
@cmdId["house"]["dta"]["9"] 		= "168"
@cmdId["house"]["dta"]["nine"] 	= "168"

# Station names to channel numbers.  
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@stationId = Hash.new { |h,k| h[k] = Hash.new }
@stationId["ota"]["nbc"] = "5.1"
@stationId["ota"]["cbs"] = "12.1"
@stationId["ota"]["radar"] = "12.3"
@stationId["ota"]["weather"] = "12.3"
@stationId["ota"]["abc"] = "25.1"
@stationId["ota"]["fox"] = "29.1"
@stationId["ota"]["pbs"] = "42.1"

# Get URL for current room and device
@reFile = "#{Dir.home}/.siriproxy/resel.csv"
@reSel = Hash.new
if File.exists?(@reFile)
	@reSel = Hash[CSV.read(@reFile)]
else
	@reSel["redeye"] = "living"
	@reSel["room"] = "living"
	@reSel["device"] = "tv"
	@reSel["feed"] = "ota"
	write_resel
end

end