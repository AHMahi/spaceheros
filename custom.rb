#Custom.rb
require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

module ZOrder
  BACKGROUND, SHIP, PLAYER, UI = *0..3
end


#In the update() method, we create a random number each frame. It that number
#is less than ENEMY_FREQUENCY, a new enemy is added to the array using the
#push() method.
WIDTH = 600
HEIGHT = 800

class Class_window < Gosu::Window
def initialize
super(WIDTH, HEIGHT)
self.caption = 'Space Hero'
@player = Player.new(self)
@enemies = Array.new
@bullets = Array.new
@explosions = Array.new # stores the sections of the sprite image
@backgroud = Gosu::Image.new("resources/images/space.png")
@explosion_sound = Gosu::Sample.new("resources/sounds/explosion.mp3")
@game_music = Gosu::Song.new("resources/sounds/start.wav")
@game_music.play(true)# setting to true makes sure that the music continiously goes on as long as the window is open
@shooting_sound = Gosu::Sample.new("resources/sounds/laser2.wav")
@enemies_appeared = 0
@enemies_destroyed = 0
@score = 0
@life = 100
@font = Gosu::Font.new(20)
@level = 1
@level_up = @level+1
@enemy_frequency = 2
@level_frequency = @enemy_frequency+1
#@explosione = @explosions.push Explosion.new(self, enemy.x, enemy.y)
end

#we create a bullet by passing in the position and angle of the player ship as arguments to the initialize() method.
def button_down(id)
if id == Gosu::KbSpace
@bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
@shooting_sound.play
end
end

def update
@player.turn_left if button_down?(Gosu::KbLeft)
@player.turn_right if button_down?(Gosu::KbRight)
@player.accelerate if button_down?(Gosu::KbUp)
@player.move

@enemies.each do |enemy|
enemy.move
end

if rand(1..150) < @enemy_frequency# when rand is used without any arguments it returns a value between 0 and 1
  @enemies.push Enemy.new(self)
end

@bullets.each do |bullet|#To move the bullets, we use the each() method of the array, sending the move() message to each bullet.
  bullet.move
  end
@enemies.dup.each do |enemy|#By using Ruby’s dup() method, we are iterating through each array input and removing the required objects from them.
  @bullets.dup.each do |bullet|
    distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)#Gosu.distance calculates the distance between any two points in the scene.
    if distance < enemy.radius + bullet.radius
      @enemies.delete enemy#   The delete() method of the Array class removes the argument of the method from the array
      @bullets.delete bullet
      #When Gosu calls the draw() method, any enemies we’ve deleted are no longer in the array, and so are no longer drawn in the window.
      @explosions.push Explosion.new(self, enemy.x, enemy.y)
      @explosion_sound.play(0.5)# plays the explosion sound
      @score = @score+1
    end
  end

distance2 = Gosu.distance(enemy.x, enemy.y, @player.x, @player.y)
if distance2 < enemy.radius + @player.radius
    @life = @life - 1
    #@explosione
    #@explosion_sound.play(0.5)# plays the explosion sound
  end
if @life == 0
  @score = 0
  @life = 100
end

if @score > 10
  @level = @level_up
  @enemy_frequency = @level_frequency
end

end
@explosions.dup.each do |explosion|
  @explosions.delete explosion if explosion.finished#we check all of our explosions, and remove any whose @finished has been set to true
end
@enemies.dup.each do |enemy| # this loop checks id the enemy is still in the window every frame and if it is not then delete method is called and it gets removed from the array
  if enemy.y > HEIGHT + enemy.radius
    @enemies.delete enemy
  end
end
@bullets.dup.each do |bullet| # this loop checks id the bullet is still in the window every frame and if it is not then delete method is called and it gets removed from the array
  @bullets.delete bullet unless bullet.onscreen?#onscreen?() is true only if the bullet is between the left and right edges, and also between the top and bottom we import this method from bullets.rb
end
end

def draw
@backgroud.draw(0, 0, ZOrder::BACKGROUND)
@player.draw
@enemies.each do |enemy|
#use the each() method to draw all the enemies. here "enemy" is temporary variable each of the elements of the array gets a turn being enemy,
#and each has its move() method called.
enemy.draw
end
@bullets.each do |bullet|# we draw each bullet like how we drew each Enemy
bullet.draw
end
@explosions.each do |explosion|
explosion.draw
end
@font.draw("Score: #{@score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
@font.draw("Life: #{@life}", 510, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
@font.draw("Level: #{@level}", 250, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
end

end
window = Class_window.new
window.show
