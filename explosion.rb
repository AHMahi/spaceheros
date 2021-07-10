class Explosion

attr_reader :finished

def initialize(window, x, y)
@x = x
@y = y
@radius = 32
@images = Gosu::Image.load_tiles('resources/images/expsprite.png', 64, 64)# img size 256 each row has 4 img so 256/4 = 64
@image_index = 0
@finished = false
end

def draw
if @image_index < @images.count#if condition here checks if we have gone through all the 16 sprites
@images[@image_index].draw(@x - @radius, @y - @radius, 2)
@image_index += 1
else
@finished = true# If we try to daw the 17th no pic the array crashes and we set the @finished value to true
end
end

end
