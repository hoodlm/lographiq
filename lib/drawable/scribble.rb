require 'lib/drawable/drawable'
require 'lib/drawable/draw_helpers'
require 'lib/drawable/line'

# Scribble is a generic drawable that's composed of a number of vertices.
# When drawn, short line segments will be drawn from vertex to the next.
class Scribble < Drawable
  include DrawHelpers

  # Points are in a two-dimensional array, e.g.
  # [
  #   [1, 2],
  #   [3, 4],
  #   [5, 6],
  # ]
  #
  attr_reader :points, :color
  def initialize(points, color)
    @points = points
    fail "Must supply at least two points to make a Scribble" unless points.length >= 2
    @color = color
  end

  def apply_to(canvas, draw_options = {})
    (points.length - 1).times do |i|
      line = Line.new(points[i][0], points[i][1], points[i+1][0], points[i+1][1], @color)
      line.apply_to(canvas, draw_options)
    end
    super
  end
end
