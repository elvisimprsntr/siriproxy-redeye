siriproxy-redeye
================

About
-----
Siriproxy-redeye is a [SiriProxy] (https://github.com/plamoni/SiriProxy) plugin that uses the REST API of [Thinkflood's RedEye] (http://thinkflood.com) series of IP to IR control devices.  It does not require a jailbreak, nor do I endorse doing so.

First, you must have SiriProxy installed and working.  

Second, you must have at least one RedEye unit configured with a static IP address on your network and already programmed to control your IR devices.   

Third, you will need to manually use the REST API to extract the information you need to make changes to this plugin for your setup.  

Here is a short demonstration video: http://www.youtube.com/watch?v=Q81HMnjCGb8 


RedEye
------

ThinkFlood has added a REST API to both the original RedEye WiFi unit as well as the RedEye Pro models.   There is no REST API for the RedEye Mini. 

The [RedEye Advanced Programming Manual] (http://thinkflood.com/products/redeye/programming-manual.pdf) documents the REST API for both the Redeye and the RedEye Pro.    

Here is a simple [BASH script] (https://gist.github.com/3961767) which you can modify to retreive the information you need to modify this plugin for your setup.  

Support for multiple RedEye units is thanks in part to some of the very talented folks at [Stackoverflow] (http://stackoverflow.com) and for helping me improve my code.  Admittedly, I still have a lot more to learn and improve upon as this is my first SiriProxy plugin from scratch. 



Installation
------------

- Navigate to the SiriProxy plugins directory  

`cd ~/SiriProxy/plugins/`

- Get the latest repo   

`wget "https://github.com/elvisimprsntr/siriproxy-redeye/zipball/master"`

- Unzip the repo  

`unzip master`

- Create a symbolic link. **Note: Replace #'s as appropriate.**  

`ln -sf elvisimprsntr-siriproxy-redeye-####### siriproxy-redeye`

- Add the example configuration to the master config.yml  

`cat siriproxy-redeye/config-info.yml >> ~/.siriproxy/config.yml`

- Edit the config.yml as required.     **Note: Make sure to line up the column spacing.**

`vim ~/.siriproxy/config.yml`

- Edit the redeyeconfig.rb as you wish.  **Note: Repeat all the following steps if you make additional changes.**    

`vim siriproxy-redeye\lib\redeyeconfig.rb`

- Copy the repo and the symbolic link to the appropriate install directory.  **Note: Replace #'s as appropriate.  Replace /usr/local/rvm/ with ~/.rvm/ depending on your Linux distribution**     

`cp -rv elvisimprsntr-siriproxy-redeye-####### /usr/local/rvm/gems/ruby-1.9.3-p###@SiriProxy/gems/siriproxy-0.3.#/plugins/`    
`cp -rv siriproxy-redeye /usr/local/rvm/gems/ruby-1.9.3-p###@SiriProxy/gems/siriproxy-0.3.#/plugins/`    

- Navigate the SiriProxy directory  

`cd ~/SiriProxy`

- Bundle  

`siriproxy bundle`

- Install  

`bundle install`

- Run  

`rvmsudo siriproxy server`

Usage
-----

**Channel (number)**
- Changes the channel

**Station (name)**
- Changes the channel

**Command (command)**
- Sends a single IR command

**RedEye (name)**   
- Will change RedEye units if you have more than one.  
- Writes selected RedEye to file for improved reliability.

To Do List
----------

Let me know if you want to collaborate.   

- Determine if there is a way to pass in a key/value hash.
- Add ability to control multiple devices
- Make plugin self aware of your configuration using the REST interface.
- Pull in channel guide from Zap2It or some other TV guide database.


Licensing
---------

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).

