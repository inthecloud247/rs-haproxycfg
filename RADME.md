# rs-haproxycfg
Creates Haproxy configuration dynamically based on:

+ Server Array instances
+ Servers within a deployment matching a nickname prefix. 

Generated configuration can be printed to screen or saved directly to disk. When saving to disk a backup of configuration file is always created. Configuration file is not updated if configuration on disk is already the same as dynamically generated one. 

## Installation
Clone or fork the project

## Depencies

+ [rest_connection]/(https://github.com/rightscale/rest_connection)
+ [trollop](http://gitorious.org/projects/trollop)

## Configuration
+ See [rest_connection]/(https://github.com/rightscale/rest_connection) configuration guide
+ Create Haproxy configuration template, see _template/haproxy.cfg.example.erb_ for details.

## Example usage
Generate configuration using Server Array instances

	ruby -rubygems bin/rs-haproxycfg --print --array 123456789 --template templates/haproxy.cfg.example.erb
	
Generate configuration using server nicknames & deployment id (example matches instances within deployment 123456789 with nickname web[0-9]+)

	ruby -rubygems bin/rs-haproxycfg --print --deployment 123456789 --nickname web --template templates/haproxy.cfg.example.erb

Generate configuration and save it to disk

	ruby -rubygems bin/rs-haproxycfg --array 123456789 --template templates/haproxy.cfg.example.erb --config /etc/haproxy/haproxy.cfg

## License
(The MIT License)

Copyright(c) 2012 Applifier Ltd.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.