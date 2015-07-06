require 'lib/canvas'
require 'lib/drawable/scribble'

SEED = 1238597
WIDTH = 1920 * 2
HEIGHT= 1080 * 2
image = Canvas.new(WIDTH, HEIGHT, RGB.black)
random = Random.new(SEED)

def random_point(rng)
  [rng.rand(0..WIDTH - 1), rng.rand(0..HEIGHT - 1)]
end

def generate_random_shape(rng, verts = 4, color = nil, starting_point = nil)
  starting_point ||= random_point(rng)
  color ||= RGB.new(rng.rand(0..255), rng.rand(0..255), rng.rand(0..255))

  points = [starting_point]
  (verts - 1).times { points << random_point(rng) }
  points << starting_point

  # $stderr.puts("Creating random shape with points: #{points}")
  Scribble.new(points, color)
end

starting_point = [WIDTH / 2, HEIGHT / 2]

N_ITERATIONS = 500
N_ITERATIONS.times do |i|
  $stderr.puts ("#{Time.now} #{100.0 * i / N_ITERATIONS}%") if i % 5 == 0
  color = RGB.new(random.rand(0..80), random.rand(180..255), random.rand(0..255))
  generate_random_shape(random, 3, color, starting_point).apply_to(image, blend_mode: :average, weight: 0.25)
end

image
