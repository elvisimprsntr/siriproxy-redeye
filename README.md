siriproxy-redeye
================

About
-----
Siriproxy-redeye is a [SiriProxy] (https://github.com/plamoni/SiriProxy) plugin that uses the REST API of [Thinkflood's RedEye] (http://thinkflood.com) series of IP to IR control devices.  It does not require a jailbreak, nor do I endorse doing so.

First, you must have SiriProxy installed and working.  

Second, you must have at least one RedEye unit configured with a static IP address on you home network and already programmed to control your IR devices.   

Third, you will need to manually use the REST API to extract the information you need to make changes to this plugin for your setup.  

Here is a short demonstration video: Coming soon…   

RedEye
------

ThinkFlood has added a REST API to both the original RedEye WiFi unit as well as the RedEye Pro models.   There is no REST API for the RedEye Mini. 

The [RedEye Advanced Programming Manual] (http://thinkflood.com/products/redeye/programming-manual.pdf) documents the REST interface for both the Redeye and the RedEye Pro.    

Here is a simple [BASH script] (https://gist.github.com/3961767) which you can modify to retreive the information you need to modify this plugin for your setup.  

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

- Edit the plugin as you wish.  **Note: Repeat all the following steps if you make additional changes.**    

`vim siriproxy-redeye\lib\siriproxy-redeye.rb`

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

- Channel (number)

Changes the channel

- Station (name)

Changes the channel

- Command (command)

Sends a single IR command

To Do List
----------

Let me know if you want to collaborate.   

- Pull in channel guide from Zap2It or some other TV guide database.
- Make plugin self aware of your configuration using the REST interface.


Licensing
---------

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).

