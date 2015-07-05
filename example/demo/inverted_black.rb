require 'lib/canvas'
require 'lib/effects/invert'

WIDTH = 640
HEIGHT= 480
image = Canvas.new(WIDTH, HEIGHT)
invert_image(image)
