require 'lib/canvas'
require 'lib/drawable/scribble'

SEED = 79
WIDTH = 3000
HEIGHT= 3000
image = Canvas.new(WIDTH, HEIGHT, RGB.black)
random = Random.new(SEED)

current_color = RGB.new(255, 80, 80)
DENSITY = 10
n_iterations = WIDTH / (DENSITY * 2)
(n_iterations).times do |i|

  $stderr.puts "#{Time.now} #{100 * i/n_iterations}%" if i % 10 == 0
  local_width = WIDTH - (i * DENSITY)
  local_height = HEIGHT - (i * DENSITY)
  points =
  [
    [local_width * 0.25, 10], [local_width * 0.75, 10],
    [local_width - 10, local_height * 0.25], [local_width - 10, local_height * 0.75],
    [local_width * 0.75, local_height - 10], [local_width * 0.25, local_height - 10],
    [10, local_height * 0.75], [10, local_height * 0.25],
    [local_width * 0.25, 10]
  ]

  current_color = RGB.new(current_color.r + random.rand(-3..3), current_color.g + random.rand(-3..3), current_color.b + random.rand(-3..3))
  scribble = Scribble.new(points, current_color)
  scribble.apply_to(image, blend_mode: :random, rng: random)
end

image
