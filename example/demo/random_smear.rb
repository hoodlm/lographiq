require 'lib/canvas'
require 'lib/drawable/random_path'

SEED = 40030
WIDTH = 1920
HEIGHT= 1080
PATH_LENGTH = 500
BACKGROUND = RGB.black
N_PATHS = 400
COLORS = 
  [
    RGB.new(128, 255, 0),
    RGB.new(0, 128, 255),
    RGB.new(255, 0, 128),
  ] 

PATH_DIR_DIST = {
  [0, 1] => 4,
  [0.74, 1] => 1,
  [-0.74, 1] => 1,
}

image = Canvas.new(WIDTH, HEIGHT, BACKGROUND)
random = Random.new(SEED)

N_PATHS.times do |i|
  $stderr.puts "#{Time.now} #{100.0 * i.to_f / N_PATHS.to_f}%" if (i % 10 == 0)
  COLORS.map do |color|
    origin_x = random.rand(WIDTH)
    origin_y = random.rand(HEIGHT)
    path = RandomPath.new(origin_x, origin_y, PATH_LENGTH, color, PATH_DIR_DIST, random)
    path.apply_to(image, blend_mode: :random, rng: random)
  end
end

image
