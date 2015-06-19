require 'lib/canvas'
require 'lib/drawable/random_path'

SEED = 40031
WIDTH = 1920 * 2
HEIGHT= 1080 * 2
N_PATHS = 20000
PATH_LENGTH = 4000
BACKGROUND = RGB.new(63, 72, 84)
COLORS = [
  RGB.new(175, 210, 185),
  RGB.new(132, 169, 109),
  RGB.new(210, 255, 235),
  RGB.new(170, 160, 150),
]
image = Canvas.new(WIDTH, HEIGHT, BACKGROUND)
random = Random.new(SEED)



N_PATHS.times do |i|
  $stderr.puts "#{Time.now} #{100.0 * i.to_f / N_PATHS.to_f}%" if (i % 100 == 0)
  origin_x = random.rand(WIDTH)
  origin_y = random.rand(HEIGHT)
  color = COLORS[random.rand(COLORS.length)]
  RandomPath.new(origin_x, origin_y, PATH_LENGTH, color, :uniform, random).apply_to(image)
end

image
