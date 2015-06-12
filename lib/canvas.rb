require 'ostruct'

# Represents a single pixel.
# RGB values should be between 0 and 255.
class RGB < OpenStruct
  def self.black
    RGB.new(0, 0, 0)
  end

  def self.clone(rgb)
    RGB.new(rgb.r, rgb.g, rgb.b)
  end

  def initialize(r = 0, g = 0, b = 0)
    super(r: r, g: g, b: b)
  end
end

class Canvas
  PPM_RGB_DELIMITER = "\t"
  PPM_ROW_DELIMITER = "\n"
  attr_reader :width, :height
  def initialize(width, height, background_color = RGB.black)
    $stderr.puts "Initializing canvas: size = #{width}x#{height}"
    @width = width
    @height = height

    @canvas = []
    @height.times do |row|
      row = @canvas[row] = []
      @width.times do |column|
        row[column] = RGB.clone(background_color)
      end
    end
    $stderr.puts "Done initializing canvas"
  end

  def set_pixel(r, g, b, x, y)
    rgb = @canvas[y][x]
    rgb.r = r
    rgb.g = g
    rgb.b = b
  end

  def render_as_ppm
    $stderr.puts "Rendering image as ppm..."

    # Boilerplate header.
    header = "P3\n#{@width} #{@height}\n255\n"

    header + @canvas.map do |row|
      row.map do |pixel|
        [pixel.r, pixel.g, pixel.b].map do |value|
          # clamp between 0 and 255
          [0, [value, 255].min].max 
        end.join(PPM_RGB_DELIMITER)
      end.join(PPM_RGB_DELIMITER)
    end.join(PPM_ROW_DELIMITER)
  end
end
