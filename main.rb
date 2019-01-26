require './emulator.rb'

# Run the emulator code.
emulator = Emulator.new

# Register the SIGINT and SIGTERM signals.
Signal.trap('INT') { emulator.close } # Ctrl + C
Signal.trap('TERM') { emulator.close } # Terminating process

# Wait until the emulator has completed its execution.
until emulator.done
  sleep(1)
end
