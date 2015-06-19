require 'lib/canvas'

class Drawable
  def apply_to(canvas, draw_args = {})
    # Should be implemented in subclasses
  end

  # Draw a pixel to the canvas.
  # Valid options...
  #   - blend_mode
  #      :overwrite - (DEFAULT) Cover up the pixel's current color with the new color. Ignores weight.
  #      :average   - Blend together with the pixel's current color by averaging with current color.
  #                   (Degree of blending is determined by 'weight' - defaults to 0.50, an equal mix.)
  #      :random    - Randomizes RGB elements, bounded between current color and new color. Ignores weight.
  #   - weight
  #      Between 0.00 and 1.00. Depends on the blend_mode, but in general controls the degree
  #      to which this pixel will be altered.
  #   - rng
  #      Used for non-deterministic blending methods.
  def draw_pixel(canvas, color, x, y, options = {})
    mode = options.fetch(:blend_mode, :overwrite)
    weight = options.fetch(:weight, 0.50)
    fail "weight must be between 0.00 and 1.00" unless (weight >= 0.00 && weight <= 1.00)
    x = x.floor
    y = y.floor
    case mode
    when :overwrite
      canvas.set_pixel(color, x, y)
    when :average
      current_color = canvas.get_pixel(x, y)
      inv_weight = 1.00 - weight
      r = (current_color.r.to_f * inv_weight + color.r.to_f * weight) * 0.5
      g = (current_color.g.to_f * inv_weight + color.g.to_f * weight) * 0.5
      b = (current_color.b.to_f * inv_weight + color.b.to_f * weight) * 0.5
      new_color = RGB.new(r, g, b)
      canvas.set_pixel(new_color, x, y)
    when :random
      rng = options.fetch(:rng, Random.new())
      current_color = canvas.get_pixel(x, y)
      new_rgb = [:r, :g, :b].map do |comp|
        bounds = [current_color.send(comp), color.send(comp)].sort
        rng.rand(Range.new(bounds[0], bounds[1])).tap do |new_comp|
          # $stderr.puts("Randomly between #{current_color.send(comp)} and #{color.send(comp)} -> #{new_comp}")
        end
      end
      canvas.set_pixel(RGB.new(new_rgb[0], new_rgb[1], new_rgb[2]), x, y)
    else
      fail "unknown blend mode #{mode}."
    end
  end
end
