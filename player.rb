require 'gosu'

class Player

ROTATION_SPEED = 2
ACCELERATION = 1
FRICTION = 0.8
#we need to get the position and direction of the player ship in the main file in order to create a bullet. so we create an attr_reader
attr_reader :x, :y, :angle, :radius #a helper built in for getting instance variables
#This line is a shortcut that creates four methods x(), y(), angle(), and radius(). Each of these methods returns the value of the appropriate instance variable.
#we use these in the main file to create the bullets
def initialize(window)
@x = 300#position of our ship (initially)
@y = 700
@angle = 0
@image = Gosu::Image.new('resources/images/ships.png')
@velocity_x = 0
@velocity_y = 0
@radius = 20
@window = window  #@player, needs to know some information about another object that is the borders of the window so we call window here
end               #so we save the reference to the window object in an instance variable called @window.

#gets drawn in the main draw function
def draw
@image.draw_rot(@x, @y, 1, @angle)#this method draws the image rotated by any angle
end


#gets called in update of main file
def turn_right
@angle += ROTATION_SPEED
end

def turn_left
@angle -= ROTATION_SPEED
end

def move
@x = @x +  @velocity_x#position of our ship changes as we press key in the move method
@y = @y + @velocity_y
@velocity_x = @velocity_x * FRICTION
@velocity_y = @velocity_y * FRICTION
if @x > @window.width - @radius
  @velocity_x = 0
  @x = @window.width - @radius
end
if @x < @radius
  @velocity_x = 0
  @x = @radius
end
if @y > @window.height - @radius
  @velocity_y = 0
  @y = @window.height - @radius
end
end


def accelerate
@velocity_x += Gosu.offset_x(@angle, ACCELERATION)#The offset_x() method takes the : angle , and an, amount, as arguments, and returns the amount in the x direction here 2 is the movement speed along facing direction
@velocity_y += Gosu.offset_y(@angle, ACCELERATION)#we change the velocity of the ship in the direction that the ship is currently pointing using offset
end

end
