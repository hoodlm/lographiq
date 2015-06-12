require 'lib/canvas'

WIDTH = 256 
HEIGHT = 256
image = Canvas.new(WIDTH, HEIGHT)

$stderr.puts "Generating noise..."
random = Random.new()
WIDTH.times do |x|
  HEIGHT.times do |y|
    r = random.rand(0..255)
    g = random.rand(0..255)
    b = random.rand(0..255)
    image.set_pixel(r, g, b, x, y)
  end
end

image
