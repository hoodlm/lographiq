require 'lib/effects/effects_common'

def invert_image(image)
  $stderr.puts("#{Time.now} Inverting image...")
  each_pixel_in_image(image) do |x, y, rgb|
    image.set_pixel(invert_rgb(rgb), x, y)
  end
  image
end

def invert_rgb(rgb)
  RGB.new(255 - rgb.r, 255 - rgb.g, 255 - rgb.b)
end
