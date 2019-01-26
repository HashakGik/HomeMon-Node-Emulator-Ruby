HomeMon Node Emulator
=====================

This Ruby script emulates the behavior of a sensor node, in order to better debug the [HomeMon application](https://github.com/HashakGik/HomeMon-MFC-Cpp).

It periodically sends a randomly generated update string (`variable value\r\n`) over a serial port.

Setup
-----

* Install a Ruby interpreter (it should be preinstalled on most Linux machines)
* Install the `serialport` gem (`gem install "serialport"`)
* Connect a serial port (either physical or virtual, e.g. a bluetooth adapter, or a VM pipe) to another machine running HomeMon.

Configuration
-------------

Edit the modules `EMULATOR_CONFIG` and `SERIAL_CONFIG` in `config.rb`.

* `VALUES`: range of values which can be generated (HomeMon expects single byte values, i.e. from 0 to 255)
* `VARS`: variable names
* `REFRESH_RATE`: rate (in milliseconds) at which the emulator will update its variables and send an output.

Usage
-----

Simply run `ruby main.rb` from the script folder (or `load "main.rb"` from an `irb` session).