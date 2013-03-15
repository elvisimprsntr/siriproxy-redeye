siriproxy-redeye
================

About
-----
Siriproxy-redeye is a [SiriProxy] (https://github.com/plamoni/SiriProxy) plugin that uses the REST API of [Thinkflood's RedEye] (http://thinkflood.com) series of IP to IR control devices.  It does not require a jailbreak, nor do I endorse doing so.

First, you must have SiriProxy installed and working.  [HOW-TOs for SiriProxy] (https://github.com/plamoni/SiriProxy/wiki/Installation-How-Tos) 

Second, you must have at least one RedEye unit configured with a static IP address on your network and already programmed to control your IR devices.   

Third, siriproxy-redeye plugin will now auto detect your RedEye configuration, but you will need to customize the redeyeconfig.rb file for your specific installation. 

Here is a short demonstration video: http://www.youtube.com/watch?v=PXmCiaRc9XU#t=01m33s 

I can't thank enough some of very talented folks at [Stackoverflow] (http://stackoverflow.com) for helping me improve my code.  Admittedly, I still have a lot more to learn and improve upon as this is my first SiriProxy plugin from scratch. 

I have received offers to make a donation to help offset the cost of hardware and for my time.  If you feel so inclined you can donate thru PayPal.  

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=SB6A4AFSC5LFQ)  


RedEye
------

ThinkFlood has added a REST API to both the original RedEye WiFi unit as well as the RedEye Pro models.   There is no REST API for the RedEye Mini. 

The [RedEye Advanced Programming Manual] (http://thinkflood.com/products/redeye/programming-manual.pdf) documents the REST API for both the Redeye and the RedEye Pro.    

Here is a simple [BASH script] (https://gist.github.com/3961767) which you can modify to retrieve the information you need to modify this plugin for your setup.  

**Note: In order to change channels with sub-channel numbers, you will need to change the dash command name from "Dash" to "." in your RedEye units for the applicable tuner devices.  You will need to change the redeye/room/activity/device/command names to something that can be spoken since siriproxy-redeye performs a direct match against the Siri response.  You can also add additional entries to the cached YAML configuration files for variability in Siri response, but keep in mind siriproxy-redeye will write over those cached configuration files if a file error is detected or you command siriproxy-redeye to reinitialize.**



Installation (New for SiriProxy 0.5.0+)
---------------------------------------


- Install DNSSD library dependancies

`apt-get install libavahi-compat-libdnssd-dev -y` 

- Create a plugins directory  

`mkdir ~/plugins`  

`cd ~/plugins/` 

- Get the latest repo   

`git clone git://github.com/elvisimprsntr/siriproxy-redeye`

- Add the example configuration to the master config.yml  

`cat siriproxy-redeye/config-info.yml >> ~/.siriproxy/config.yml`

- Edit the config.yml as required.     **Note: Make sure to line up the column spacing.**

`vim ~/.siriproxy/config.yml`

- Edit the redeyeconfig.rb as you wish.  **Note: Repeat all the following steps if you make additional changes.**    

`vim siriproxy-redeye/lib/redeyeconfig.rb`

- Bundle  

`siriproxy bundle`

- Run (Ref: https://github.com/plamoni/SiriProxy#set-up-instructions)  

`[rvmsudo] siriproxy server [-d ###.###.###.###] [-u username]`


Usage
-----

**Redeye initialize**
- Will re-initialize the plugin when you have made changes to your RedEye units.

**Channel (number {point number})**
- Changes the channel.
- Supports both integer and OTA sub-channel numbers.

**Station (name)**
- Changes the channel.

**Activity (name)**
- Launches an activity.

**Command (command)**
- Sends a single IR command.

**RedEye (name)**   
- Change RedEye units if you have more than one.  
- Prompts you to select a new room.

**Room (name)**
- Change room, if you have more than one room for RedEye Pro.
- Prompts you to select a new device.

**Device (name)** 
- Change device, if you have more than one device per room.

**Feed (name)** 
- Changes the station name/channel lookup.


To Do List
----------

If you want to collaborate, review the issues list for things to implement.  Fork, modify, test, and submit a pull request. 
<<<<<<< HEAD
=======

>>>>>>> itterating on auto discovery

Licensing
---------

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).

