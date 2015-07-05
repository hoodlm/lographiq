require 'lib/canvas'

def each_pixel_in_image(image)
  image.width.times do |x|
    image.height.times do |y|
      yield(x, y, image.get_pixel(x, y))
    end
  end
end
