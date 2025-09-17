include image
include reactors

data Player:
    player(x, y)
end

data Thing:
    thing(x, y, speed)
end

data World:
    world(score, timer, player, thing1, thing2, thing3)
end

# define initial world
PLAYER1 = player(320, 380)
ENEMY   = thing(600, 390, 5)
RUBY    = thing(1500, 250, 20)
CLOUD   = thing(700, 100, 5)
player-image = scale(0.4, image-url("http://www.bootstrapworld.org/materials/fall2015/courses/bs1/resources/images/ninjacat.png"))
cloud-image  = scale(0.5, image-url("http://www.bootstrapworld.org/materials/fall2015/courses/bs1/resources/images/clouds.png"))
ruby-image   = scale(0.4, image-url("http://www.bootstrapworld.org/materials/fall2015/courses/bs1/resources/images/ruby.png"))
dog-image    = scale(0.5, image-url("http://www.bootstrapworld.org/materials/fall2015/courses/bs1/resources/images/dog.png"))
bg-image = image-url("http://www.bootstrapworld.org/clipart/Curriculum/bg.jpg")

# some sample worlds (at the start of the game, and at some random playing time)
START = world(0, 0, PLAYER1, ENEMY, RUBY, CLOUD)
PLAY  = world(0, 0, PLAYER1, ENEMY, thing(100, 150, 30), thing(100, 100, 20))


# draw-world
fun draw-world(w):
  if game-over(w):
    place-image(text("Game Over! Press the spacebar to play again.", 20, "white"),
      320, 240,
      rectangle(640, 480, "solid", "black"))
  else: 
    place-image(text(
        string-append(
          "NinjaCat!                                              Score:",
          num-to-string(w.score)), 
        20, 
        "white"),
      310, 10,   
      place-image(text("Use arrow keys to move. Jump on the dog and catch the ruby!", 12, "white"),
        320, 30,
        place-image(
          player-image,
          w.player.x,
          w.player.y,
          place-image(
            cloud-image,
            w.thing3.x,
            w.thing3.y,
            place-image(
              ruby-image,
              w.thing2.x,
              w.thing2.y,
              place-image(
                dog-image,
                w.thing1.x,
                w.thing1.y,
                bg-image))))))
  end
end

# update a thing
fun update-thing(t): thing(t.x - t.speed, t.y, t.speed) end

# update a player
fun update-player(p):
  if (p.y < 380): player(p.x, p.y + 14)
  else: p
  end
end

# player-distance
fun player-distance(p, t): num-sqrt(num-sqr(p.x - t.x) + num-sqr(p.y - t.y)) end

# collide? 
fun collide(p, t): player-distance(p, t) < 130 end

# update the world
fun update-world(w):
  ask:
    | (game-over(w)) then: w
    | collide(w.player, w.thing1)
      and (w.player.y > 250)
      and (w.player.y < 300) then:
      world(
        w.score + 10,
        w.timer,
        player(w.player.x, 200),
        thing(-1000, 0, 0),
        w.thing2,
        w.thing3)
    | collide(w.player, w.thing2) then:
      world(
        w.score + 1,
        w.timer,
        update-player(w.player),
        update-thing(w.thing1),
        thing(-400, 0, 0),
        update-thing(w.thing3))
    | (w.thing1.x < 0) then:
      world(
        w.score,
        w.timer - 1,
        update-player(w.player),
        thing(700, 390, 5),
        update-thing(w.thing2),
        update-thing(w.thing3))
    | (w.thing2.x < 0) then:
      world(w.score,
        w.timer - 1,
        update-player(w.player),
        update-thing(w.thing1),
        thing(1000 + random(1000), 100 + random(200), 20),
        update-thing(w.thing3))
    | (w.thing3.x < 0) then:
      world(w.score,
        w.timer - 1,
        update-player(w.player),
        update-thing(w.thing1),
        update-thing(w.thing2),
        thing(700, random(200), 5))
    | otherwise: world(
        w.score,
        w.timer - 1,
        update-player(w.player),
        update-thing(w.thing1),
        update-thing(w.thing2),
        update-thing(w.thing3))
  end
end

# key-press
fun _key-press(w, k):
  ask:
    | game-over(w) and string-equal(k, " ") then: START
    | string-equal(k, "up") and (w.player.y >= 320) then:
      world(
        w.score,
        w.timer,
        player(w.player.x, 100),
        w.thing1,
        w.thing2,
        w.thing3)
    | string-equal(k, "right") and (w.player.x < 600) then:
      world(
        w.score,
        w.timer,
        player(w.player.x + 20, w.player.y),
        w.thing1,
        w.thing2,
        w.thing3)
    | string-equal(k, "left") and (w.player.x > 50) then:
      world(
        w.score,
        w.timer,
        player(w.player.x - 20, w.player.y),
        w.thing1,
        w.thing2,
        w.thing3)
    | otherwise: 
      world(
        w.score,
        w.timer,
        w.player,
        w.thing1,
        w.thing2,
        w.thing3)
  end
end

# game over
fun game-over(w):
  collide(w.player, w.thing1) and (w.player.y > 350)
end

game = reactor:
  seconds-per-tick: 0.05,
  title: "NinjaCat",
  on-tick: update-world,
  init: START,
  to-draw: draw-world,
  on-key: _key-press
end

game.interact()
