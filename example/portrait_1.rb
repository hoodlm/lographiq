require 'lib/canvas'
require 'lib/drawable/random_path'

SEED = 4284080230840180
WIDTH = 1920 * 2
HEIGHT= 1080 * 2
BACKGROUND = RGB.black

image = Canvas.new(WIDTH, HEIGHT, BACKGROUND)
random = Random.new(SEED)

# bkgrd texture
$stderr.puts "#{Time.now} drawing lines on the background"
begin
  vector = {[HEIGHT, WIDTH / 35.0] => 1}
  stroke = RandomPath.new(0, 0, HEIGHT * 120, RGB.new(30, 30, 30), vector, random)
  stroke.apply_to(image, blending_mode: :random, rng: random)
end

# horizon is greenish
$stderr.puts "#{Time.now} Starting horizon"
begin
  n_horizon_passes = 1
  n_horizon_passes.times do |horizon_pass|
    horizon_bottom = (HEIGHT - 5).to_i
    horizon_top = (horizon_bottom - (HEIGHT * 0.20)).to_i
    horizon_vector_dist = { [1,0] => 8, [1, 1] => 1, [1, -1] => 1, [1, 0.5] => 1, [1, -0.5] => 1 }
    horizon_base_color = RGB.new(80, 30, 30)
  
    horizon_y_jitter = 5
    horizon_x_jitter = 5
    horizon_color_jitter = 10

    (horizon_top..horizon_bottom).each do |origin_y|
      # randomize components slightly
      origin_x = random.rand(1..horizon_x_jitter)
      origin_y += random.rand(-horizon_y_jitter..horizon_y_jitter)
      r, g, b = [:r, :g, :b].map do |comp|
        horizon_base_color.send(comp) + random.rand(-horizon_color_jitter..horizon_color_jitter)
      end
      stroke = RandomPath.new(origin_x, origin_y, WIDTH*3, RGB.new(r, g, b), horizon_vector_dist, random)
      stroke.apply_to(image, blending_mode: :random, rng: random)
    end
  end
end

$stderr.puts "#{Time.now} Starting face"
# face
begin
  face_center_x = (WIDTH / 2).to_i
  face_center_y = (HEIGHT / 2).to_i

  skin_color_jitter = 11

  skin_base_color = RGB.new(70, 70, 70)
  skin_passes = 80
  skin_passes.times do
    r, g, b = [:r, :g, :b].map do |comp|
      skin_base_color.send(comp) + random.rand(-skin_color_jitter..skin_color_jitter)
    end
    stroke = RandomPath.new(face_center_x, face_center_y, WIDTH * 42, RGB.new(r, g, b), :uniform, random)
    stroke.apply_to(image, blending_mode: :random, rng: random)
  end
end

image
