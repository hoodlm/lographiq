require 'lib/drawable/drawable'
require 'lib/drawable/draw_helpers'

class Line < Drawable
  include DrawHelpers

  attr_reader :origin_x, :origin_y, :terminal_x, :terminal_y, :color
  def initialize(origin_x, origin_y, terminal_x, terminal_y, color)
    @origin_x = origin_x
    @origin_y = origin_y
    @terminal_x = terminal_x
    @terminal_y = terminal_y
    @color = color
  end

  def apply_to(canvas, draw_options = {})
    points_along_line().each do |point|
      draw_pixel(canvas, @color, point[0], point[1], draw_options)
    end
    super
  end

  def points_along_line
    points = []
    dx = terminal_x - origin_x
    dy = terminal_y - origin_y
    vector = to_unit_vector(dx, dy)
    current_point = [@origin_x, @origin_y]
    loop do
      points << [current_point[0], current_point[1]] # force deep copy
      [0,1].each do |i|
        current_point[i] += vector[i]
      end
      x_distance = (current_point[0] - @origin_x).abs
      y_distance = (current_point[1] - @origin_y).abs
      if (x_distance >= dx.abs) && (y_distance >= dy.abs)
        break
      end
    end
    points
  end
end
