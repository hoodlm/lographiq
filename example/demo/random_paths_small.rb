require 'lib/canvas'
require 'lib/drawable/random_path'

SEED = 40030
WIDTH = 800
HEIGHT= 600
N_PATHS = 150
PATH_LENGTH = 600
BACKGROUND = RGB.new(0, 0, 0)
COLORS = [
  RGB.new(255, 0, 0),
  RGB.new(0, 255, 0),
  RGB.new(0, 0, 255),
]
image = Canvas.new(WIDTH, HEIGHT, BACKGROUND)
random = Random.new(SEED)



N_PATHS.times do |i|
  $stderr.puts "#{Time.now} #{100.0 * i.to_f / N_PATHS.to_f}%" if (i % 5 == 0)
  origin_x = random.rand(WIDTH)
  origin_y = random.rand(HEIGHT)
  color = COLORS[random.rand(COLORS.length)]
  RandomPath.new(origin_x, origin_y, PATH_LENGTH, color, :uniform, random).apply_to(image, blend_mode: :average, weight: 0.75)
end

image
