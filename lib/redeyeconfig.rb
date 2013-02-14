# This file is where you define defaults and/or add custom configuration

def init_custom

# Default redeye, room, device, and station names.
# Note: Must all be lower case. Use same names at define in your RedEye units.
@default = Hash.new
@default["redeye"] = "living room"
@default["room"] = "living room"
@default["device"] = "tv"
@default["feed"] = "antenna"

# Station names to channel numbers.  
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@stationID = Hash.new { |h,k| h[k] = Hash.new }
@stationID["antenna"]["nbc"] = "5.1"
@stationID["antenna"]["cbs"] = "12.1"
@stationID["antenna"]["radar"] = "12.3"
@stationID["antenna"]["weather"] = "12.3"
@stationID["antenna"]["abc"] = "25.1"
@stationID["antenna"]["fox"] = "29.1"
@stationID["antenna"]["pbs"] = "42.1"

end