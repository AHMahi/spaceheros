require 'gosu'

class Bullet

#Global Constant variables
SPEED = 7
attr_reader :x, :y, :radius# to make these def methods accessible in the main file

def initialize(window, x, y, angle)
@x = x
@y = y
@direction = angle
@image = Gosu::Image.new('resources/images/bullet2.png')
@radius = 3
@window = window
end

#we use this in the update method of main file we loop through the bullets, and remove the ones that are no longer in the window.
def onscreen?
right = @window.width + @radius
left = -@radius
top = -@radius
bottom = @window.height + @radius
@x > left and @x < right and @y > top and @y < bottom
end

def move
@x += Gosu.offset_x(@direction, SPEED)
@y += Gosu.offset_y(@direction, SPEED)
end

def draw
@image.draw(@x - @radius, @y - @radius, 1)
end

end
