
require 'serialport'

require './value.rb'
require './config.rb'

class Emulator
  # Constructor. Opens the serial port and starts a new thread.
  def initialize
    @vals = Hash.new
    EMULATOR_CONFIG::VARS.each {|v| @vals[v] = Value.new}
    @rnd = Random.new
    @done = false
    begin
      @serial = SerialPort.new(SERIAL_CONFIG::PORT,
                               SERIAL_CONFIG::BAUD,
                               SERIAL_CONFIG::DATA_BITS,
                               SERIAL_CONFIG::STOP_BITS,
                               SERIAL_CONFIG::PARITY)
      @thd = Thread.new {update}
    rescue StandardError => e
      puts "Unable to open serial port (#{e.to_s}). Aborting."
      self.close
    end
  end

  # Update method. Sends a new message and then waits for the next update until
  # it receives a termination signal.
  def update
    until @done
      var, val = self.next
      self.write(var, val)

      sleep(EMULATOR_CONFIG::REFRESH_RATE / 1000)
    end

  end

  # Close method. Invoked by an exception or as a termination signal from
  # the main thread.
  def close
    # Apparently works as expected even without a mutex
    # (which can't be used inside a method invoked by Signal.trap).
    @done = true
    @thd.join unless @thd.nil?
    @serial.close unless @serial.nil?
  end

  # Write method. Writes a message over the serial.
  def write(var, val)
    begin
      @serial.write "#{var} #{val}\r\n"
      puts "#{var} #{val}"
    rescue StandardError => e
      # Ruby does not implement write timeouts, so this exception
      # probably will never be raised.
      puts "Cannot write (#{e.to_s}). Aborting."
      self.close
    end
  end

  # Generates the next value to be sent.
  def next
    var = EMULATOR_CONFIG::VARS[@rnd.rand(EMULATOR_CONFIG::VARS.length)]
    @vals[var].next

    [var, @vals[var].val]
  end

  @thd
  @serial
  @done
  @vals
  @rnd

  attr_reader :done

end
