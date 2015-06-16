require 'lib/canvas'
require 'lib/drawable/line'

SEED = 999998
WIDTH = 800
HEIGHT= 600 
N_LINES = 5000
image = Canvas.new(WIDTH, HEIGHT, RGB.white)
random = Random.new(SEED)

N_LINES.times do |i|
  $stderr.puts "#{Time.now} #{100.0 * i.to_f / N_LINES.to_f}%" if (i % 250 == 0)
  origin_x = random.rand(WIDTH)
  terminal_x = random.rand(WIDTH)
  origin_y = random.rand(HEIGHT)
  terminal_y = random.rand(HEIGHT)
  color = RGB.new(random.rand(255), random.rand(255), random.rand(255))
  Line.new(origin_x, origin_y, terminal_x, terminal_y, color).apply_to(image)
end

image
