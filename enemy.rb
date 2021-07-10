require 'gosu'

class Enemy
#Global variables

OVER = 20
attr_reader :x, :y, :radius

def initialize(window)
@radius = 20
@x = rand(window.width - 4 * @radius) + @radius# we want the ship to not corss the borders and this random movement is only horzontal
@y = 0
@random = rand(6)
@random_l = rand(100..500)
@image = Gosu::Image.new('resources/images/enemies.png')
@image2 = Gosu::Image.new('resources/images/ene9.png')
@image3 = Gosu::Image.new('resources/images/ene11.png')
@velocity_x = 0
@velocity_y = 0
@ships = rand(1..3)
@window = window
@speed = rand(1..3)# randomizes speed of spawning enemy ships
end

def move

@y += @speed


#if @x > @window.width - OVER*2
  #@x = @window.width - OVER*2
#end
#if @x < OVER
  #@x = OVER
#end
if @y > @random_l
case @random
when 0
  @x += @speed
when 1
  @y -= @speed
  @x -= @speed
when 2
  @x += @speed
when 3
  @y -= @speed
  @x += @speed
when 4
  @y -= @speed
when 5
  @x -= @speed
end
end
end


def draw

case @ships

when 1
@image2.draw(@x - @radius, @y - @radius, 1)

when 2
@image.draw(@x - @radius, @y - @radius, 1)

when 3
@image3.draw(@x - @radius, @y - @radius, 1)

end
end
end
