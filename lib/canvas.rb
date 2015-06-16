require 'ostruct'

# Represents a single pixel.
# RGB values should be between 0 and 255.
class RGB < OpenStruct
  def self.black
    RGB.new(0, 0, 0)
  end

  def self.white
    RGB.new(255, 255, 255)
  end

  def initialize(r = 0, g = 0, b = 0)
    super(r: r, g: g, b: b)
  end
end

class Canvas
  PPM_RGB_DELIMITER = "\t"
  PPM_ROW_DELIMITER = "\n"
  attr_reader :width, :height
  def initialize(width, height, bkgd = RGB.black)
    $stderr.puts "#{Time.now} Initializing canvas: size = #{width}x#{height}"
    @width = width
    @height = height

    # Pixels is a flat array of every RGB component.
    @pixels = []
    @height.times do |y|
      @width.times do |x|
        set_pixel(bkgd, x, y)
      end
    end
    $stderr.puts "#{Time.now} Done initializing canvas"
  end

  def set_pixel(rgb, x, y)
    index = index_of_pixel(x, y)
    @pixels[index] = rgb.r
    @pixels[index + 1] = rgb.g
    @pixels[index + 2] = rgb.b
    rgb
  end

  def get_pixel(x, y)
    index = index_of_pixel(x, y)
    RGB.new(
      @pixels[index],
      @pixels[index + 1],
      @pixels[index + 2]
    )
  end

  def render_as_ppm
    $stderr.puts "#{Time.now} Rendering image as ppm..."

    # Boilerplate header.
    header = "P3\n#{@width} #{@height}\n255\n"
    @pixels.each_with_index do |value, index|
      header << value.to_s
      if (index + 1) % (@width * 3) == 0
        header << PPM_ROW_DELIMITER
      else
        header << PPM_RGB_DELIMITER
      end
    end
    $stderr.puts "#{Time.now} Done rendering image!"
    header
  end

  private
  # Returns the index of the R component of a pixel, given an X,Y coordinate.
  # The B and G components will be at the return value +1 and +2.
  def index_of_pixel(x, y)
    y * (@width * 3) + 3 * x
  end
end
