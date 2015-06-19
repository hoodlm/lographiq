require 'lib/canvas'
require 'lib/drawable/random_path'

SEED = 40030
WIDTH = 640
HEIGHT= 480
N_PATHS = 1
PATH_LENGTH = 500
BACKGROUND = RGB.black

image = Canvas.new(WIDTH, HEIGHT, BACKGROUND)
random = Random.new(SEED)

N_PATHS.times do |i|
  $stderr.puts "#{Time.now} #{100.0 * i.to_f / N_PATHS.to_f}%" if (i % 100 == 0)
  origin_x = random.rand(WIDTH)
  origin_y = random.rand(HEIGHT)
  color = RGB.new(0, 255, 0)
  RandomPath.new(origin_x, origin_y, PATH_LENGTH, color, :uniform, random).apply_to(image, weight: 0.10, blend_mode: :average)
end

image
