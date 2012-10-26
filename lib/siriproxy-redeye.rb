require 'uri'
require 'cora'
require 'httparty'
require 'rubygems'
require 'siri_objects'

class SiriProxy::Plugin::RedEye < SiriProxy::Plugin
  attr_accessor :reip1
  attr_accessor :reip2
  
  def initialize(config)
    self.reip1 = config["reip1"]
    self.reip2 = config["reip2"]
    @reUrl1 = "#{self.reip1}:8080/redeye/rooms/0/devices/2/commands/send?commandId="
    @reUrl2 = "#{self.reip2}:8080/redeye/rooms/0/devices/2/commands/send?commandId="

	@cmdZero 	= 3
	@cmdOne 	= 4
	@cmdTwo 	= 5
	@cmdThree 	= 6
	@cmdFour 	= 7
	@cmdFive 	= 8
	@cmdSix 	= 9
	@cmdSeven 	= 10
	@cmdEight 	= 11
	@cmdNine 	= 12
	@cmdChup	= 18
	@cmdChdn 	= 19
	@cmdEnter 	= 14
	@cmdInfo 	= 13
	@cmdLang 	= 21
	@cmdLast 	= 15
	@cmdMute 	= 20
	@cmdVolup 	= 16
	@cmdVoldn 	= 17

  end

  class Rest
    include HTTParty
    format :xml
  end



listen_for(/NBC/i) {nbc}
listen_for(/CBS/i) {cbs}
listen_for(/ABC/i) {abc}
listen_for(/FOX/i) {fox}
listen_for(/ESPN/i) {espn}
listen_for(/CNBC/i) {cnbc}
listen_for(/weather channel/i) {twc}


  def nbc
    say "OK. Changing the channel to NBC."
    Rest.get("#{@reUrl2}#{@cmdThree}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEnter}")
    request_completed
  end

  def cbs
    say "OK. Changing the channel to CBS."
    Rest.get("#{@reUrl2}#{@cmdNine}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEnter}")
    request_completed
  end

  def abc
    say "OK. Changing the channel to ABC."
    Rest.get("#{@reUrl2}#{@cmdOne}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdZero}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEnter}")
    request_completed
  end

  def fox
    say "OK. Changing the channel to FOX."
    Rest.get("#{@reUrl2}#{@cmdOne}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdOne}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEnter}")
    request_completed
  end

  def espn
    say "OK. Changing the channel to ESPN."
    Rest.get("#{@reUrl2}#{@cmdThree}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdThree}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEnter}")
    request_completed
  end

  def cnbc
    say "OK. Changing the channel to CNBC."
    Rest.get("#{@reUrl2}#{@cmdFour}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdThree}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEnter}")
    request_completed
  end

  def twc
    say "OK. Changing the channel to The Weather Channel."
    Rest.get("#{@reUrl2}#{@cmdFive}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEight}")
    sleep(1)
    Rest.get("#{@reUrl2}#{@cmdEnter}")
    request_completed
  end



	
end
