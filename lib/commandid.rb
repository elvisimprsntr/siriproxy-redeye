require 'cora'

def commandID

@cmdId = Hash.new
@cmdId["0"] = 3
@cmdId["1"] = 4
@cmdId["2"] = 5
@cmdId["3"] = 6
@cmdId["4"] = 7
@cmdId["5"] = 8
@cmdId["6"] = 9
@cmdId["7"] = 10
@cmdId["8"] = 11
@cmdId["9"] = 12
@cmdId["chup"] = 18
@cmdId["chdn"] = 19
@cmdId["enter"] = 14
@cmdId["info"] = 13
@cmdId["lang"] = 21
@cmdId["last"] = 15
@cmdId["mute"] = 20
@cmdId["volup"] = 16
@cmdId["voldn"] = 17

@stationId = Hash.new
@stationId["nbc"] = 3
@stationId["cbs"] = 9
@stationId["abc"] = 10
@stationId["fox"] = 11
@stationId["espn"] = 22
@stationId["cnbc"] = 43
@stationId["weather channel"] = 58

end