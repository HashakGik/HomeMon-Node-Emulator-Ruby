# Edit this file.

module EMULATOR_CONFIG
  VALUES = 0x00..0xff # HomeMon expects single byte values.
  VARS = ["bathroom_temp",
          "bedroom_temp",
          "kitchen_temp",
          "bathroom_humidity",
          "bedroom_humidity",
          "kitchen_air_quality",
          "garden_light",
          "water_tank_level"]
  REFRESH_RATE = 1000 # ms.
end

module SERIAL_CONFIG
  PORT = "COM1"
  BAUD = 9600
  DATA_BITS = 8
  STOP_BITS = 1
  PARITY = SerialPort::NONE
end