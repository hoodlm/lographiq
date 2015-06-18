require 'lib/drawable/drawable'

class RandomPath < Drawable

  INV_SQRT_TWO = (1.0 / Math.sqrt(2))
  UNIFORM_DISTRIBUTION = {
    [0, 1]=> 1,
    [0, -1]=> 1,
    [1, 0]=> 1,
    [-1, 0]=> 1,
    [INV_SQRT_TWO, INV_SQRT_TWO]=> 1,
    [INV_SQRT_TWO, -INV_SQRT_TWO]=> 1,
    [-INV_SQRT_TWO, INV_SQRT_TWO]=> 1,
    [-INV_SQRT_TWO, -INV_SQRT_TWO]=> 1,
  }

  attr_reader :origin_x, :origin_y, :length, :color, :distribution
  def initialize(origin_x, origin_y, length, color, distribution = :uniform, rng = Random.new)
    @origin_x = origin_x
    @origin_y = origin_y
    @length = length
    @color = color
    @rng = rng
    @distribution = case distribution
      when :uniform
        process_distribution(UNIFORM_DISTRIBUTION)
      else
        process_distribution(distribution)
      end
  end

  def process_distribution(distr)
    values = []
    distr.each_pair do |value, count|
      count.times do
        values << value
      end
    end
    values
  end

  def apply_to(canvas, draw_args = {})
    points_along_path().each do |point|
      draw_pixel(canvas, @color, point[0], point[1], draw_args)
    end
    super
  end

  def get_random_direction
    @distribution[@rng.rand(@distribution.length)]
  end

  def points_along_path
    points = []
    current_point = [@origin_x, @origin_y]
    @length.times do
      points << [current_point[0], current_point[1]] # force deep copy
      vector = get_random_direction()
      [0,1].each do |i|
        current_point[i] += vector[i]
      end
    end
    points
  end
end
