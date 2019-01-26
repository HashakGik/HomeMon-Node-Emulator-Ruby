require './config.rb'

# Value class. Models a randomly generated value and allows some operations
# with it.
class Value
  # Constructor. Initializes the value with init_val.
  def initialize(init_val = 0)
    @val = init_val
    @old_val = init_val
    @avg = init_val
    @sum = init_val
    @rnd = Random.new
  end

  # Generates a new value and stores the old one.
  def next
    @old_val = @val
    @val = @rnd.rand(EMULATOR_CONFIG::VALUES)
  end

  # Threshold method. If the value is above a threshold, saturates it to 0xff.
  def threshold(thr)
    if (@val >= thr)
      0xff
    else
      0x00
    end
  end

  # Derivative method. Computes an approximation of the derivative of the value
  # over time.
  # For use with HomeMon, it should be normalized in 0..0xff.
  def derivative(dx)
    ret = (@val - @old_val) / dx
    @old_val = @val

    ret
  end

  # Integration method. Computes a Reimann sum of the value over time.
  # For use with HomeMon, it should be normalized in 0..0xff.
  def integration(dx)
    @sum += @val * dx
  end

  # Exponential moving average method.
  # For use with HomeMon, it should be normalized in 0..0xff.
  def ema(alpha)
    @avg = @val * alpha + @avg * (1  - alpha)
  end

  @val
  @avg
  @old_val
  @sum
  @rnd

  attr_reader :val
end
