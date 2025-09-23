use context starter2024
provide *

include either
import error as Err
import color as C
provide from C:
  color,
  type *,
  data *
end
import math as M
include reactors
import image-structs as IS
include reactors
import starter2024 as Starter 
provide from Starter: expt, sqrt, sqr, abs, negate end
import constants as Const
provide from Const:
  *
end
import sets as S
include tables
include charts
import lists as L
provide from L: 
  *,
  type *, 
  data *
end
import image as I
provide from I:
    * hiding(translate),
  type *,
  data *
end


################# UTILITY FUNCTIONS ###########################

# courtesy of Ben Lerner
# first, we define a data structure that we can run cases on...
data TaggedFunction:
  | one(f :: (Number -> Number))
  | two(f :: (Number, Number -> Posn))
  | three(f :: (Number, Number, String -> Posn))
end

# then, we use exceptions (!) to figure out which structure to return..
fun guess-arity(f :: Function) -> TaggedFunction:
  cases (Either) run-task({(): f(0) }):
    | left(v) => one(f)
    | right(v) => 
      err = exn-unwrap(v)
      if Err.is-arity-mismatch(err):
        cases (Either) run-task({(): f(0, 0)}):
          | left(shadow v) => two(f)
          | right(shadow v) =>
            shadow err = exn-unwrap(v)
            if Err.is-arity-mismatch(err):
              cases (Either) run-task({(): f(0, 0, 0)}):
                | left(shadow v) => three(f)
                | right(shadow v) =>
                  shadow err = exn-unwrap(v)
                  if Err.is-arity-mismatch(err):
                    raise("Unknown function arity")
                  else: 
                    three(f)
                  end
              end
            else:
              two(f)
            end
        end
      else:
        one(f)
      end
  end
end


################################################################
#################### CUSTOM TRANSLATE DEFN #####################
shadow translate = put-image
fun min(a,b): M.min([list: a,b]) end
fun max(a,b): M.max([list: a,b]) end

################################################################
######################### BLEND IMAGES ########################
fun blend-pixels(A, B):
  IS.color(
    num-round((A.red   + B.red  ) / 2),
    num-round((A.green + B.green) / 2),
    num-round((A.blue  + B.blue ) / 2),
    num-round((A.alpha + B.alpha) / 2))
end

fun blend-images(imgA, imgB) block:
  width = num-max(image-width(imgA), image-width(imgB))
  height = num-max(image-height(imgA), image-height(imgB))
  bg = rectangle(width, height, "solid", IS.transparent)
  pixelsA = image-to-color-list(overlay(imgA, bg))
  pixelsB = image-to-color-list(overlay(imgB, bg))
  pixelsAB = map2(
    blend-pixels,
    pixelsA,
    pixelsB)
  color-list-to-image(pixelsAB, width, height, num-round(width / 2), num-round(height / 2))
end

################################################################
######################### NTH-ROOT #############################
fun nth-root(n, r): num-expt(n, 1 / r) end

################################################################
######################### ROCKET HEIGHT ########################

ROCKET = scale(1/2, image-url("http://www.wescheme.org/images/teachpacks2012/rocket.png"))
ROCKET-BG = image-url("http://www.BootstrapWorld.org/clipart/height.png")
UNIVERSE-HEIGHT = 4.35e+26
LOG-UNIVERSE-HEIGHT = 61.33738
UNIVERSE-ZERO-PX = 150
BACKGROUND-PX-ABOVE-GROUND = image-height(ROCKET-BG) - UNIVERSE-ZERO-PX
CENTER = image-width(ROCKET-BG) / 2
ROCKET-HEIGHT = 550
THANKS = text("Thanks to Randall Munroe for the picture of the universe!  https://xkcd.com/482/", 14, "gray")

fun time-text(str):
  text(str, 14, IS.color(41, 128, 38, 255))
end

fun height-text(str):
  text(str, 14, IS.color(38, 38, 128, 255))
end

fun speed-text(str):
  text(str, 14, "purple")
end

fun tock(w, ke):
  {v :: Number; f :: (Number -> Number)} = w
  ask:
    | ke == " " then: {v + 1; f}
    | v <= 0 then: {0; f}
    | ke == "b" then: {v - 1; f}
    | otherwise: w
  end
end

fun legend(w):

  fun ss(n, str):
    if num-to-rational(n) == 1: str
    else: str + "s"
    end
  end

  {v;f} = w
  time = v
  hfn = f
  height = hfn(time)
  speed = hfn(time + 1) - height
  ttime = beside(
    time-text("Time: " + tostring(time) + ss(time, "second")),
    scale(1.2, time-text("       [spacebar] adds one second.  [b] goes back!")))
  theight = height-text("Height: " + num-to-string-digits(height, 4) + ss(height, "meter"))
  light-text = if num-abs(speed) > 299792458:
    "  That's faster than light!"
  else:
    ""
  end
  tspeed = speed-text("Speed: " + num-to-string-digits(speed, 4) + ss(speed, "meter") + "/seconds"
      + light-text)
  above-align("left", ttime, above-align("left", theight, tspeed))
end

fun plain-draw(t, fn):
  PLAIN-WIDTH = 200
  place-image(
    ROCKET,
    PLAIN-WIDTH / 2,
    ROCKET-HEIGHT - fn(t),
    marks(0, ROCKET-HEIGHT, 50).foldr(
      lam(mark, bg):
        i = height-text(tostring(mark))
        place-image(i, image-width(i) / 2, (ROCKET-HEIGHT - mark) - 15, bg)
      end,
      empty-scene(PLAIN-WIDTH, ROCKET-HEIGHT)
      ))
end

fun rocket-draw-world(w):
  fun rocket-add(window):
    {time; hfn} = w
    height = hfn(time)
    rocket = scale(rocket-scale(height), ROCKET)
    rocket-pixh = universe-pix(height)
    usable-rocket-space = ROCKET-HEIGHT - UNIVERSE-ZERO-PX
    winh-p = 1 - ((BACKGROUND-PX-ABOVE-GROUND - rocket-pixh) / BACKGROUND-PX-ABOVE-GROUND)
    ydt = 0 - (winh-p * usable-rocket-space)
    y = usable-rocket-space + ydt
    bgy = rocket-pixh + ydt + (ROCKET-HEIGHT - (image-height(ROCKET-BG) / 2))
    place-image(rocket, CENTER, y, place-image(ROCKET-BG, CENTER, bgy, window))
  end

  rocket-add(rectangle(image-width(ROCKET-BG), ROCKET-HEIGHT, "solid", "white"))
end

fun universe-pix(h):
  ask:
    | h <= 0 then: h
    | otherwise:
      (num-log(1.1 + h) / LOG-UNIVERSE-HEIGHT) * BACKGROUND-PX-ABOVE-GROUND
  end
end

fun rocket-scale(height):
  k = 40
  h = 2 + num-abs(height)
  d = num-log(k * h)
  num-max(
    1/25,
    (d - num-log(h)) / d)
end

fun marks(start, stop, step):
  if start < stop:
    link(start, marks(start + step, stop, step))
  else:
    [list: stop]
  end
end

fun graph-draw-world(w):
  GRAPH-SIZE = 400
  GRAPH-LEGEND-SIZE = 20
  NUM-MARKS = 15

  fun plus-marks(start, stop, step):
    fun plus-marks-internal(shadow start, shadow stop, shadow step):
      if start < stop:
        link(start, marks(start + step, stop, step))
      else:
        [list: stop, stop + step]
      end
    end
    link(start - step, plus-marks-internal(start, stop, step))
  end

  {seconds; fn} = w
  x-step = num-max(1, num-round(num-abs(seconds) / NUM-MARKS))
  x-seconds = marks(num-min(0, seconds), num-max(0, seconds), x-step)
  y-outputs = map(fn, x-seconds)
  biggest-y = reduce(num-max, y-outputs)
  smallest-y = reduce(num-min, y-outputs)

  y-step = num-max(1, num-round((biggest-y - smallest-y) / NUM-MARKS))

  y-meters = plus-marks(smallest-y, biggest-y, y-step)

  max-seconds = reduce(num-max, x-seconds)
  min-seconds = reduce(num-min, x-seconds)
  x-range = num-max(1, max-seconds - min-seconds)
  max-meters = reduce(num-max, y-meters)
  min-meters = reduce(num-min, y-meters)

  y-range = num-max(1, max-meters - min-meters)
  x-pixel-position = lam(shadow seconds):
    (GRAPH-SIZE - GRAPH-LEGEND-SIZE) * ((seconds - min-seconds) / x-range)
  end
  y-pixel-position = lam(meters):
    GRAPH-SIZE - ((GRAPH-SIZE - GRAPH-LEGEND-SIZE) * ((meters - min-meters) / y-range))
  end
  rockets = x-seconds.foldr(
    lam(shadow seconds, bg):
      place-image(
        scale(1/5, ROCKET),
        x-pixel-position(seconds),
        y-pixel-position(fn(seconds)),
        bg)
    end,
    rectangle(GRAPH-SIZE, GRAPH-SIZE, "outline", "black")
    )
  x-legend = above(
    x-seconds.foldr(
      lam(shadow seconds, bg):
        place-image(
          time-text(tostring(seconds)),
          x-pixel-position(seconds),
          GRAPH-LEGEND-SIZE / 2,
          bg)
      end,
      rectangle(GRAPH-SIZE, GRAPH-LEGEND-SIZE, "solid", "white")
      ),
    time-text("seconds"))
  y-legend = beside(
    rotate(90, height-text("meters")),
    y-meters.foldr(
      lam(meters, bg):
        place-image(
          height-text(num-to-string-digits(meters, 2)),
          2.5 * GRAPH-LEGEND-SIZE,
          y-pixel-position(meters),
          bg)
      end,
      rectangle(5 * GRAPH-LEGEND-SIZE, GRAPH-SIZE, "solid", "white")
      ))
  beside-align("top", y-legend, above-align("right", rockets, x-legend))
end

fun combined-draw-world(w):
  {v;fn} = w
  above-align(
    "left",
    beside(
      plain-draw(v, fn),
      beside(
        rocket-draw-world(w),
        graph-draw-world(w))),
    above-align("left",
      legend(w),
      THANKS))
end

fun blastoff(fn) block:
  r = reactor:
    title: "Blastoff!",
    init: {0; fn},
    on-key: tock,
    to-draw: lam(w): 
        {v;shadow fn} = w
        above(plain-draw(v, fn), legend(w))
      end,
  end
  t = r.interact-trace()
  t.build-column("height", lam(row): fn(row["tick"]) end)
    .drop("state")
    .rename-column("tick", "seconds")
end

fun space(fn) block:
  r = reactor:
    title: "Blastoff!",
    init: {0; fn},
    on-key: tock,
    to-draw: lam(w):
        above(
          rocket-draw-world(w),
          above(
            legend(w),
            THANKS))
      end,
  end
  t = r.interact-trace()
  t.build-column("height", lam(row): fn(row["tick"]) end)
    .drop("state")
    .rename-column("tick", "seconds")
end

fun graph(fn) block:
  r = reactor:
    title: "Blastoff!",
    init: {0; fn},
    on-key: tock,
    to-draw: lam(w): above(graph-draw-world(w), legend(w)) end,
  end
  t = r.interact-trace()
  t.build-column("height", lam(row): fn(row["tick"]) end)
    .drop("state")
    .rename-column("tick", "seconds")
end

fun everything(fn) block:
  r = reactor:
    title: "Blastoff!",
    init: {0; fn},
    on-key: tock,
    to-draw: combined-draw-world,
  end
  t = r.interact-trace()
  t.build-column("height", lam(row): fn(row["tick"]) end)
    .drop("state")
    .rename-column("tick", "seconds")
end

fun reduce(f, l):
  for fold(acc from l.first, elt from l.rest):
    f(acc, elt)
  end
end

fun sanity-checks():
  test-funs = [list:
    lam(s): 0 end,
    lam(s): 100 end,
    lam(s): 100000 end,
    lam(s): s * 7 end,
    lam(s): s * 17 end,
    lam(s): s * 0.7 end,
    lam(s): s * -7 end,
    lam(s): s / 3 end,
    lam(s): 500 + (s * -7) end,
    num-sqr
    #    lam(s): num-expt(s, 5) end,
    #|lam(s): num-expt(3.1415, s) end
    lam(s): num-expt(num-abs(s) + 1, -5) end,
    lam(s): num-expt(-2, s) end,
    lam(s): num-expt(s, 7) end,
    lam(s): num-expt(10, s) end|#
  ]
  times = [list: -10, -1, 0, 1, 2, 3, 5, 10, 30, 80, 200]
  fun at-times(test-fn):
    imgs = for map(elt from times):
      scale(1/8, combined-draw-world({elt;test-fn}))
    end
    reduce(beside, imgs)
  end
  reduce(
    above-align("left", _, _),
    map(at-times, test-funs))
end


################################################################
######################### SAM THE BUTTERFLY ####################
SAM-WIDTH = 640
SAM-HEIGHT = 480

type SamWorld = {x :: Number, y :: Number, img :: Image}

fun move(w, key):
  ask:
    | key == "left"  then: w.{x: w.x - 10}
    | key == "right" then: w.{x: w.x + 10}
    | key == "up"    then: w.{y: w.y + 10}
    | key == "down"  then: w.{y: w.y - 10}
    | otherwise: w
  end
end

fun draw-sam(w):
  fun draw-butterfly(shadow w, scene):
    place-image(w.img, w.x, SAM-HEIGHT - w.y, scene)
  end
  fun draw-text(shadow w, scene):
    place-image(text(
        "x-coordinate: " + tostring(w.x) + "   y-coordinate: " + tostring(w.y),
        14,
        "black"),
      num-floor(image-width(scene) / 2),
      15,
      scene)
  end
  draw-butterfly(w, draw-text(w, empty-scene(SAM-WIDTH, SAM-HEIGHT)))
end

fun normalize-onscreen(fn):
  cases(TaggedFunction) guess-arity(fn):
    | one(f) => lam(x,y): f(x) end
    | two(f) => f
  end
end


fun sam(is-onscreen, img) block:
  shadow is-onscreen = normalize-onscreen(is-onscreen)
  update = lam(w, k):
    if is-onscreen(move(w, k).x, move(w, k).y):
      move(w, k)
    else:
      w
    end
  end
  r = reactor:
    title: "Sam the Butterfly",
    init: {x: SAM-WIDTH / 2, y:SAM-HEIGHT / 2, img:img},
    to-draw: draw-sam,
    on-key: update,
  end
  r.interact()
  nothing
end


fun trace(is-onscreen, img):
  shadow is-onscreen = normalize-onscreen(is-onscreen)
  update = lam(w, k):
    if is-onscreen(move(w, k).x, move(w, k).y):
      move(w, k)
    else:
      w
    end
  end
  interact-trace(reactor:
      init: {x: SAM-WIDTH / 2, y:SAM-HEIGHT / 2, img:img},
      to-draw: draw-sam,
      on-key: update
    end)
    .build-column("x", {(r): r["state"].x})
    .build-column("y", {(r): r["state"].y})
    .drop("state")
end


is-continent :: String -> Boolean
fun is-continent(x) block: 
  test = string-to-lower(x)
  ask:
    | string-equal(test, "europe") then: true
    | string-equal(test, "south america") then: true
    | string-equal(test, "asia") then: true
    | string-equal(test, "north america") then: true
    | string-equal(test, "antarctica") then:  true
    | string-equal(test, "australia") then: true
    | string-equal(test, "africa") then: true
    | otherwise: false
  end
end

is-primary-color :: String -> Boolean
fun is-primary-color(x): 
  ask:
    | string-equal(x, "blue") then: true
    | string-equal(x, "red") then: true
    | string-equal(x, "yellow") then: true
    | otherwise: false
  end
end

is-less-than-one :: Number -> Boolean
fun is-less-than-one(n):
  n < 1
end

is-even :: NumInteger -> Boolean
fun is-even(n):
  num-modulo(n, 2) == 0
end
is-odd :: NumInteger -> Boolean
fun is-odd(n):
  not(is-even(n))
end

################################################################
###################### INEQUALITIES SIMULATOR ##################

# some constants for drawing, intervals, etc
STRIP-WIDTH = 400
STRIP-HEIGHT = 30
tri = rotate(90, triangle(10, "solid", "black"))
num-intervals = 10
c1 = C.color(100, 100, 255, 0.5)

strip = rectangle(STRIP-WIDTH + 48, STRIP-HEIGHT, "outline", "transparent")
inequalities-bg = overlay(rectangle(STRIP-WIDTH, 2, "solid", "black"), strip)
axis = translate(flip-horizontal(tri), 
  STRIP-WIDTH + 38, STRIP-HEIGHT / 2, 
  translate(tri, 10, STRIP-HEIGHT / 2, inequalities-bg))

fun num-to-mark(n):
  if num-is-integer(n): num-to-string(n) 
  else: num-to-string-digits(n, 2) end
end

# given a textcolor, a fn to draw the point, and a projection fn,
# produce a function that consumes a point and an image, then draws
# a dot of that color
fun dot-builder(draw-point, project, points, base):
  points.foldl(
    lam(p, img):
      translate(draw-point(p), project(p) + 24, STRIP-HEIGHT / 2, img)
    end,
    base)
end

# build a strip of labeled points
fun label-builder(project, points, alignment, c):
  points.foldl(
    lam(p, img):
      translate(
        overlay-align("center", alignment,
          rotate(90, text(num-to-mark(p), 10, c)),
          square(30, "solid", "transparent")),
        project(p) + 24, STRIP-HEIGHT / 2,
        img)
    end,
    strip)
end

# given an inequality fn and a reverse-projection fn, test every pixel
# on a 600px range and mark "true" pixels as transparent blue
fun draw-shade(f, rProject, c):
  range-by(0, STRIP-WIDTH, 2).foldl(lam(p, img): 
      shadow color = if f(rProject(p)): c else: "transparent" end
      beside(img, rectangle(2, 15, "solid", color))
    end,
    rectangle(0,0,"solid","transparent"))
end

fun draw-inequality(points, f, msg-img) block:
  # find the start and stop of the range
  start = M.min(points)
  stop = M.max(points)
  # given one of the points on the range, project to pixels on the axis
  fun project(p): (p - start) * (STRIP-WIDTH / (stop - start)) end
  # given a pixel on the axis, reverse-project back to a point on the range
  fun rProject(p): (p / (STRIP-WIDTH / (stop - start))) + start end
  # make a list of all the interval coordinates
  intervals = range-by(start, stop, (stop - start) / num-intervals)
  # make a strip containing all those intervals
  intervals-strip = label-builder(project, intervals, "top", "darkgray")
  # make a strip containing all the points
  points-strip = label-builder(project, points, "bottom", "black")
  # starting with the blank axis, add the shade...
  axis-strip = translate(draw-shade(f, rProject, c1),
    (STRIP-WIDTH + 50) / 2, STRIP-HEIGHT / 2, axis)
  # add the interval dots
  black-dots-strip = dot-builder(lam(p): circle(2, "solid", "black") end, project, intervals, axis-strip)
  # add the points
  dots-strip = dot-builder(lam(p): translate(
        text(if f(p): "T" else: "F" end, 10, "black"),
        10, 8,
      circle(10, "solid", if f(p): "green" else: "red" end)) end,
    project, points, black-dots-strip)
  when (points.length() <> 8):
    raise("the list must contain exactly 8 points")
  end
  above-list([list: strip, points-strip, dots-strip, intervals-strip, msg-img])
end

# given a list of numbers and an inequality function,
# check to see if the list contains 8 elements, then graph
# the inequality and the points on a numberline
# report back which points passed
fun inequality(f, points): 
  passed = points.foldl(lam(p, count): (if f(p): count + 1 else: count end) end, 0)
  msg-img = if (passed == 4):
    text(" ", 20, "green")
  else: text("Challenge yourself: Find 4 true examples and 4 false", 20, "red")
  end
  draw-inequality(points, f, msg-img)
end

fun or-union(f1, f2, points):
  msg-img = text("All regions shaded blue are part of the solution", 20, "blue")
  overlay-align(
    "center", "top",
    text("UNION", 20, "black"),
    draw-inequality(points, lam(x): f1(x) or f2(x) end, msg-img))
end

fun and-intersection(f1, f2, points):
  start = M.min(points)
  stop = M.max(points)
  f = lam(x): f1(x) and f2(x) end
  has-intersection = L.any(f, range-by(0, 600, 1))
  msg-img = if has-intersection:
    text("All regions shaded blue are part of the solution", 20, "blue")
  else: text("No solution exists within this range!", 20, "blue")
  end
  overlay-align(
    "center", "top",
    text("INTERSECTION", 20, "black"),
    draw-inequality(points, lam(x): f1(x) and f2(x) end, msg-img))
end

# DEBUGGING HELP
#|
   small-lst = [list: -4, -3, -2, -1, 1, 2, 3, 4]
   big-lst = [list: -400, -300, -200, 100, 200, 300, 400, 1000]
   fun is-positive(x): x > 0 end
   fun gt5(x): x > 5 end
   fun lt1(x): x < 1 end
   fun lt15(x): x < 15 end


   "A simple inequality, with feedback for num-passing"
   inequality(is-positive, big-lst)
   "A union with overlap"
   or-union(gt5, lt15, range-by(3, 24 + 1, 3))
   "A union with NO overlap"
   or-union(lt1, gt5, range-by(-21, 24 + 1, 6))
   "An intersection with overlap"
   and-intersection(gt5, lt15, range-by(3, 24 + 1, 3))
   "An intersection with NO overlap"
   and-intersection(lt1, gt5, range-by(-21, 24 + 1, 6))
|#

################################################################
########################### THE VIDEOGAME ######################

GAME-WIDTH       = 640
GAME-HEIGHT      = 480
EXPLOSION-COLOR  = "gray"
var _TITLE-COLOR = "white"
var _BACKGROUND  = rectangle(GAME-WIDTH, GAME-HEIGHT, "solid", "black")

fun spacing(): 100 + random(200) end

_target-increment_ = 20
_danger-increment_ = -50
LOSS-SCORE = 0
GAMEOVER_IMG = image-url("http://www.wescheme.org/images/teachpacks2012/gameover.png")

var _score_    = 0
var _player-x_ = 0
var _player-y_ = 0

var _line-length_ = lam(a, b): 0 end
var _distance_    = lam(px, cx, py, cy): 0 end
var _DISTANCES-COLOR_ = ""

TOLERANCE = 20

RESTING-TOP-DOWN-ORIENTATION = 40

fun fit-image-to(w, h, an-image):
  height-scaled = ((w / h) * image-height(an-image))
  ask:
    | image-width(an-image) == height-scaled then:
      scale(image-width(an-image) / w, an-image)
    | image-width(an-image) > height-scaled then:
      scale(
        w / ((w / h) * image-height(an-image)),
        crop(0, 0, (w / h) * image-height(an-image), image-height(an-image), an-image))
    | image-width(an-image) < height-scaled then:
      scale(
        w / image-width(an-image),
        crop(0, 0, image-width(an-image), (h / w) * image-width(an-image), an-image))
  end
end

fun cull(beings :: List<Being>) -> List<Being>:
  for filter(b from beings):
    p = b.posn
    (p.x > 0) and (p.x < GAME-WIDTH) and
    (p.y > 0) and (p.y < GAME-HEIGHT)
  end
end


data Posn:
  | posn(x :: Number, y :: Number) 
end

data Being:
  | being(posn :: Posn, costume :: Image, cullable :: Boolean) 
end

type world = {
  dangers :: List<Being>,
  shots :: List<Being>,
  targets :: List<Being>,
  player :: Being,
  bg :: Image,
  score :: Number,
  title :: String,
  timer :: Number
}

fun posn-to-point(p :: Posn) -> Posn:
  posn(p.x, GAME-HEIGHT - p.y)
end

fun add-informative-triangle(
    cx :: Number,
    cy :: Number,
    shadow color :: String,
    background):

  player-point = posn-to-point(posn(_player-x_, _player-y_))
  px = player-point.x
  py = player-point.y
  if (px == cx) and (py == cy):
    background
  else:
    dx = cx - px
    dy = cy - py
    n-to-s = lam(num): tostring(num-exact(num-round(num))) end
    place-image(
      text(n-to-s(_line-length_(cx, px)), 12, color),
      cx - (dx / 2),
      cy,
      place-image(
        line(dx, 0, color),
        cx - (dx / 2),
        cy,
        place-image(
          text(n-to-s(_line-length_(cy, py)), 12, color),
          px,
          cy - (dy / 2),
          place-image(
            line(0, dy, color),
            px,
            cy - (dy / 2),
            place-image(
              text(n-to-s(_distance_(px, py, cx, cy)), 12, color),
              cx - (dx / 2),
              cy - (dy / 2),
              place-image(
                line(dx, dy, color),
                cx - (dx / 2),
                cy - (dy / 2),
                background))))))
  end
end

fun draw-being(b :: Being, background):
  screen-point = posn-to-point(b.posn)
  cx = screen-point.x
  cy = screen-point.y
  dbg-bkgnd = if not(_DISTANCES-COLOR_ == ""):
    add-informative-triangle(cx, cy, _DISTANCES-COLOR_, background)
  else:
    background
  end
  translate(b.costume, b.posn.x, b.posn.y, dbg-bkgnd)
end

fun draw-game(w :: world):
  score-string = w.title + "                    score:" + tostring(w.score)
  player = if w.timer > 0:
    being(w.player.posn, radial-star(7, 1.5 * w.timer, 0.25 * w.timer, "solid", EXPLOSION-COLOR), w.player.cullable)
  else:
    w.player
  end
  all-beings = w.targets + w.dangers + w.shots + [list: player]
  block:
    # update globals in case students want to use them
    _player-x_ := w.player.posn.x
    _player-y_ := w.player.posn.y
    _score_ := w.score
    if w.score <= 0:
      GAMEOVER_IMG
    else:
      translate(
        text-font(score-string, 18, _TITLE-COLOR, "default", "default", "italic", "bold", true),
        num-floor(image-width(_BACKGROUND) / 2),
        image-height(_BACKGROUND) - 20,
        all-beings.foldl(draw-being, _BACKGROUND))
    end
  end
end



fun make-game(title, title-color, background, 
    dangerImgs, update-danger,
    targetImgs, update-target,
    playerImg, update-player,
    projectileImgs, update-projectile,
    show-distances, line-length, distance,
    collide, onscreen):
  [list:
    title, title-color, background, 
    dangerImgs, update-danger,
    targetImgs, update-target,
    playerImg, update-player,
    projectileImgs, update-projectile,
    show-distances, line-length, distance,
    collide, onscreen]
end

# finally, we normalize all animation functions to take both x and y
fun normalize-npc(fn):
  cases(TaggedFunction) guess-arity(fn):
    | one(f) => lam(x,y): posn(f(x), y) end
    | two(f) => f
  end
end
fun normalize-player(fn):
  cases(TaggedFunction) guess-arity(fn):
    | two(f) => lam(x, y, k): posn(x, f(y, k)) end
    | three(f) => f
  end
end

fun wrap-npc-for-being(f) -> (Being -> Being):
  lam(b):
    new-posn = f(b.posn.x, b.posn.y)
    if is-posn(new-posn):
      being(new-posn, b.costume, b.cullable)
    else if is-number(new-posn):
      being(posn(new-posn, b.posn.y), b.costume, b.cullable)
    else:
      raise("update-danger or update-target returned something other than a posn or number")
    end
  end
end

fun wrap-player-for-being(f):
  lam(p, k):
    result = f(p.posn.x, p.posn.y, k)
    if is-number(result):
      being(posn(p.posn.x, result), p.costume, p.cullable)
    else if is-posn(result):
      being(result, p.costume, p.cullable)
    else:
      raise("update-player didn't return a posn or number")
    end
  end
end

# passes all the args to animate-proc, wrapping all the animation
# functions so they take in a consistent number of args regardless
# of arity. This allows kids to write simple functions first, then 
# make them more complex
fun play(g) block:
  animate-proc(
    g.get(0), # title
    g.get(1), # title-color
    g.get(2), # background
    g.get(3), # dangerImgs
    wrap-npc-for-being(normalize-npc(g.get(4))), # update-danger
    g.get(5), # targetImgs
    wrap-npc-for-being(normalize-npc(g.get(6))), # update-target
    g.get(7), # playerImg
    wrap-player-for-being(normalize-player(g.get(8))), # update-player
    g.get(9), # projectileImgs
    wrap-npc-for-being(normalize-npc(g.get(10))),# update-projectile
    g.get(11),# distances-color
    g.get(12),# line-length
    g.get(13),# distance
    g.get(14),# collide
    normalize-onscreen(g.get(15)) # onscreen
    )
  nothing
end

fun flatten(x):
  ask:
    | is-empty(x) then: empty
    | not(is-link(x)) then: [list: x]
    | otherwise: flatten(x.first) + flatten(x.rest)
  end
end

fun animate-proc(title, title-color, background, 
    dangerImgs, update-danger,
    targetImgs, update-target,
    playerImg, update-player,
    projectileImgs, update-projectile,
    distances-color, line-length, distance,
    collide, onscreen) block:
  # TODO(joe): error checking


  _TITLE-COLOR  := title-color
  _BACKGROUND   := fit-image-to(GAME-WIDTH, GAME-HEIGHT, background)
  _line-length_ := line-length
  _distance_    := distance
  _DISTANCES-COLOR_ := distances-color

  fun reset(b :: Being, f :: (Being -> Being)) -> Being:
    next-posn = f(being(posn(1, 1), empty-image, false)).posn
    next-x = next-posn.x - 1
    next-y = next-posn.y - 1
    random-posn = if num-abs(next-y) > num-abs(next-x):
      if next-y < 0:
        posn(num-random(GAME-WIDTH), spacing() + GAME-HEIGHT)
      else:
        posn(num-random(GAME-WIDTH), spacing() * -1)
      end
    else:
      if next-x < 0:
        posn(spacing() + GAME-WIDTH, num-random(GAME-HEIGHT))
      else:
        posn(spacing() * -1, num-random(GAME-HEIGHT))
      end
    end
    being(random-posn, b.costume, false)
  end

  player = being(
    posn(GAME-WIDTH / 2, GAME-HEIGHT / 2), 
    center-pinhole(playerImg), 
    false)
  is-onscreen = lam(b): onscreen(b.posn.x, b.posn.y) end
  is-collision = lam(b1, b2): collide(b1.posn.x, b1.posn.y, b2.posn.x, b2.posn.y) end

  is-hit-by = lam(b, enemies): L.any(lam(e): is-collision(b, e) end, enemies) end
  reset-chars = lam(chars, enemies, update):
    #| 
       for each character....
       1) if it's been hit, reset it
       2) if it's onscreen, update it and make sure cullable=true
       3) if it's not cullable, update it as-is
       4) if it's not hit or onscreen, AND it's cullable - reset
    |#
    for map(b from chars) block:
      if is-hit-by(b, enemies):
        reset(b, update)
      else if is-onscreen(b):
        update(being(b.posn, b.costume, true))
      else if not(b.cullable): 
        update(b)
      else:
        reset(b, update)
      end
    end
  end

  init-world = {
    dangers: for map(img from flatten([list: dangerImgs])):
        reset(being(posn(0, 0), center-pinhole(img), false), update-danger)
      end, 
    shots: empty, 
    targets: for map(img from flatten([list: targetImgs])):
        reset(being(posn(0, 0), center-pinhole(img), false), update-target)
      end, 
    player: player, 
    bg: background, 
    score: 100, 
    title: title, 
    timer: 0
  }

  shadow key-press = lam(w, key):
    ask:
      | (key == " ") and (w.score <= LOSS-SCORE) then: init-world
      | w.score <= LOSS-SCORE then: w
      | key == "release" then: w
      | key == "escape" then: w.{timer: -1}
        # TODO(joe): missing a check here to do with noticing update-projectile
      | key == " " then:
        w.{shots: link(being(posn(_player-x_, _player-y_), projectileImgs, false), w.shots)}
      | otherwise: w.{player:update-player(w.player, key)}
    end
  end

  update-world = lam(w):

    hitables = link(w.player, w.shots)
    shadow dangers = reset-chars(w.dangers, hitables, update-danger)
    was-hit = L.any(lam(s): is-hit-by(s, w.dangers) end, w.shots)
    score = w.score + if was-hit: _target-increment_ else: 0 end
    shootables = w.dangers + w.targets

    next-world = w.{
      dangers: dangers,
      shots:   reset-chars(cull(w.shots), shootables, update-projectile),
      targets: reset-chars(w.targets, hitables, update-target),
      score:   score
    }

    ask:
      | w.score <= LOSS-SCORE then: w
      | w.timer > 0 then: next-world.{timer: w.timer - 10}
      | is-hit-by(w.player, w.dangers) then:
        next-world.{score: score + _danger-increment_, timer: 100}
      | is-hit-by(w.player, w.targets) then:
        next-world.{score: score + _target-increment_}
      | otherwise:
        next-world
    end
  end

  r = reactor:
    title: title,
    init: init-world,
    stop-when: lam(w): w.timer == -1 end,
    on-tick: update-world,
    seconds-per-tick: 0.1,
    to-draw: draw-game,
    on-key: key-press
  end
  r.interact()
  nothing
end





################################################################
############### GRAPHING AND TABLE FUNCTIONS 

def-to-table :: (f :: (Number -> Number)) -> Table
# Consumes a function, and produces an x/y table
fun def-to-table(f):
  start = num-random(20) - 10
  step = num-random(5) + 1
  xs = L.range-by(start, start + 100, step)
  ys = xs.map(f)
  [table-from-columns: {"x"; xs}, {"y"; ys}]
end

def-to-graph :: (f :: (Number -> Number)) -> Image
# Same as make-table, but makes a line-plot of the resulting table
fun def-to-graph(f) block:
  render-chart(from-list.function-plot(f))
    .x-axis("x")
    .y-axis("y")
    .x-min(-10)
    .x-max(10)
    .y-min(-10)
    .y-max(10)
    .display()
end

table-to-graph :: (t :: Table) -> Image
# Consumes a table, and makes a line-plot from the first 2 columns
fun table-to-graph(t) block:
  cols = t.column-names()
  if (cols.length() < 2): 
    raise("The table must have at least two columns")
  else: nothing
  end
  xs = t.column(cols.get(0))
  ys = t.column(cols.get(1))
  
  xMin = if (num-round(min(xs)) == num-round(max(xs))):
    num-round(min(xs)) - 5
  else: num-round(min(xs))
  end
  xMax = if (num-round(min(xs)) == num-round(max(xs))):
    num-round(min(xs)) + 5
  else: num-round(max(xs))
  end
  
  yMin = if (num-round(min(ys)) == num-round(max(ys))):
    num-round(min(ys)) - 5
  else: num-round(min(ys))
  end
  yMax = if (num-round(min(ys)) == num-round(max(ys))):
    num-round(min(ys)) + 5
  else: num-round(max(ys))
  end
  
  render-chart(from-list.line-plot(xs, ys))
    .x-axis(cols.get(0))
    .y-axis(cols.get(1))
    .x-min(xMin)
    .x-max(xMax)
    .y-min(yMin)
    .y-max(yMax)
    .display()
end

fun make-graph(f) block:
  render-chart(from-list.function-plot(f))
    .x-axis("x")
    .y-axis("y")
    .x-min(-10)
    .x-max(10)
    .y-min(-10)
    .y-max(10)
    .get-image()
end


################################################################
############### FLAGS ##################
japan-flag =  image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/japan-flag-image.png")

lebanon-flag = image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/lebanon-flag-image.png")

mexico-flag = image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/mexico-flag-image.png")

panama-flag = image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/panama-flag-image.png")

puerto-rico-flag = image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/pr-flag-image.png")

trinidad-flag = image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/trinidad-and-tobago-flag-image.png")

turkey-flag = image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/turkey-flag-image.png")

################################################################
############### PERMUTATIONS AND COMBINATIONS ##################
factorial :: (n :: NumNonNegative) -> Number
fun factorial(n):
  if (n <= 1): 1
  else: n * factorial(n - 1)
  end
end

permute-wo-replace :: <A>(items :: List<A>, choose :: Number) -> List<List<A>>
fun permute-wo-replace(items, choose):
  if items.length() == 0: [list:]
  else if choose == 0: [list:]  # nothing to choose -> empty list
  else if choose == 1: items.map(lam(e): [list: e] end)
  else:
    items.foldl(lam(e, acc):
        rest = permute-wo-replace(items.remove(e), choose - 1).map(lam(p): 
          link(e, p) end)
        acc.append(rest)
      end,
      [list:])
  end
end

examples "permute-wo-replace":
  permute-wo-replace([list: 1], 1) is [list: [list:1]]
  permute-wo-replace([list: 1, 2], 2) is [list: [list:1,2], [list:2,1]]
  permute-wo-replace([list: 1, 2, 3], 2) is [list: 
    [list: 1, 2], [list: 1, 3],
    [list: 2, 1], [list: 2, 3],
    [list: 3, 1], [list: 3, 2]]
  permute-wo-replace([list: 1, 2, 3], 3) is [list: 
    [list: 1, 2, 3], [list: 1, 3, 2], 
    [list: 2, 1, 3], [list: 2, 3, 1], 
    [list: 3, 1, 2], [list: 3, 2, 1]]
end

permute-w-replace :: <A>(items :: List<A>, choose :: Number) -> List<List<A>>
fun permute-w-replace(items, choose):
  if items.length() == 0: [list:]
  else if choose == 0: [list:]
  else if choose == 1: items.map(lam(e): [list: e] end)
  else:
    items.foldl(lam(e, acc):
        rest = permute-w-replace(items, choose - 1).map(lam(p): 
          link(e, p) end)
        acc.append(rest)
      end,
      [list:])
  end
end

#|
   examples "permute-w-replace":
  permute-w-replace([list: 1], 1) is [list: [list:1]]
  permute-w-replace([list: 1, 2], 2) is [list: [list:1,1], [list:1,2], [list:2,1], [list:2,2]]
  permute-w-replace([list: 1, 2, 3], 2) is [list: 
    [list: 1, 1], [list: 1, 2], [list: 1, 3],
    [list: 2, 1], [list: 2, 2], [list: 2, 3], 
    [list: 3, 1], [list: 3, 2], [list: 3, 3]]
  permute-w-replace([list: 1, 2, 3], 3) is [list: 
    [list: 1, 1, 1], [list: 1, 1, 2], [list: 1, 1, 3], 
    [list: 1, 2, 1], [list: 1, 2, 2], [list: 1, 2, 3], 
    [list: 1, 3, 1], [list: 1, 3, 2], [list: 1, 3, 3], 
    [list: 2, 1, 1], [list: 2, 1, 2], [list: 2, 1, 3], 
    [list: 2, 2, 1], [list: 2, 2, 2], [list: 2, 2, 3], 
    [list: 2, 3, 1], [list: 2, 3, 2], [list: 2, 3, 3], 
    [list: 3, 1, 1], [list: 3, 1, 2], [list: 3, 1, 3], 
    [list: 3, 2, 1], [list: 3, 2, 2], [list: 3, 2, 3], 
    [list: 3, 3, 1], [list: 3, 3, 2], [list: 3, 3, 3]]
   end
|#

combine-wo-replace :: <A>(items :: List<A>, choose :: Number) -> List<List<A>>
# from https://rosettacode.org/wiki/Combinations#Pyret
fun combine-wo-replace(items, choose):
  if items.length() < choose:
    raise("The list must be at least as long as the number of choices")
  else if items.length() == choose: [list: items]
  else if choose == 1: items.map(lam(e): [list: e] end)
  else:
    # The main resursive step here is to consider
    # all the combinations of the list that have the
    # first element (aka head) and then those that don't
    # don't.
    cases(List) items:
      | empty => [list:]
      | link(first, rest) =>
        # All the subsets of our list either include the
        # first element of the list or they don't.
        with-first = combine-wo-replace(rest, choose - 1).map(
          lam(c): link(first, c) end)
        without-first = combine-wo-replace(rest, choose)
        with-first.append(without-first)
    end
  end
end


examples "combine-wo-replace":
  combine-wo-replace([list:], 0) is [list: [list:]]
  combine-wo-replace([list:1], 1) is [list: [list: 1]]
  combine-wo-replace([list:1, 2], 1) is [list: [list:1], [list: 2]]
  combine-wo-replace([list:1, 2, 3], 2) is 
  [list: [list:1,2], [list: 1,3], [list:2,3]]
end

render-list :: (lst :: List) -> Image
fun render-list(lst):
  lst-imgs = lst.map(lam(l):
      elt-imgs = l.map(lam(e): 
          if is-image(e): e
          else if is-string(to-repr(e)): text(e, 12, "black")
          else: to-repr(e)
          end
        end)
      beside-list(elt-imgs)
    end)
  unspoken-img(above-list(lst-imgs))
end

fun whats-missing(answer, test):
  answer-set = S.list-to-set(answer)
  test-set = S.list-to-set(test)
  diff = answer-set.difference(test-set)
  if diff.size() > 0: diff.to-list()
  else: "You got them all!"
  end
end

fun unspoken-img(img): color-list-to-image(image-to-color-list(img), image-width(img), image-height(img), image-pinhole-x(img), image-pinhole-y(img)) end


# debugging stuff
_tri = triangle(20, "solid", "red")
_cir = circle(10, "solid", "yellow")
_sq = square(20, "solid", "blue")
_star = star(10, "solid", "pink")
_ellipse = ellipse(10, 20, "solid", "green")
_img-list = [list: _tri, _cir, _sq, _star, _ellipse]

################################################################
######################### SURFACE AREA ########################

prism = 
  image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1Ckagp7bnDSY4fwRdUC-UIDmZuVQderOG")

########################################################
# how much padding to put around each image (in px)
padding = 10

#########################################################
# Image comparison functions (used for sorting)
fun img-compare(img1, img2):
  (image-height(img1) >= image-height(img2)) and 
  (image-width(img1) > image-width(img2))
end
fun img-eq(img1, img2):
  image-height(img1) == image-height(img2)
end

#########################################################
# Image transformation functions

# print-imgs :: (img-lst :: List<Image>) -> Image
# maximize height and add padding to each image, then
# sort them in order of decreasing heights
# stick them together until we hit 500px,
# then start a new row
fun print-imgs(img-lst) block:

  # if an image is wider than it is tall, rotate it 90°
  fun maximize-height(img):
    if (image-height(img) > image-width(img)): img
    else: rotate(90, img)
    end
  end
  # Add an extra padding on either side an image
  fun add-padding(img):
    w = image-width(img) + padding
    h = image-height(img) + padding
    overlay(img, rectangle(w, h, "solid", "transparent"))
  end
  fun add-dimensions(img):
    w = image-width(img)
    h = image-height(img)
    wS = num-to-string(w)
    hS = num-to-string(h)
    txt = text([list:wS, "x", hS].join-str(""), 100, "black")
    scaled-txt = if (image-width(img) > image-height(img)):
      scale(0.5, scale(w / image-width(txt), txt))
    else: 
      rotate(90, scale(0.5, scale(w / image-height(txt), txt)))
    end
    translate(
      scaled-txt, 
      (w / 2),
      (h / 2),
      img)
  end


  # if it's the first image, just add it
  # otherwise grab the last row, and see if we can add the image
  # if not, start a new row
  fun processor(img, acc):
    if (acc.length() == 0): acc.push(img)
    else:
      var split = L.split-at(1,acc)
      var lastRow = split.prefix.last()
      if ((image-width(lastRow) + image-width(img)) > 500):
        acc.push(img)
      else: 
        split.suffix.push(beside(lastRow,img))
      end
    end
  end


  img-lst
    .map(maximize-height)
    .sort-by(img-compare, img-eq)
    .map(add-dimensions)
    .map(add-padding)
    .foldl(processor, [list:])
    .foldl(lam(img, acc): below(img, acc) end, 
    square(padding,"solid","transparent"))
end

# some images for testing
#|
   img1 = rectangle(340,180,"outline","black")
   img2 = rectangle(180, 50,"outline","black")
   img3 = rectangle(50,340,"outline","black")
   img4 = rectangle(270,75,"outline","black")
   img5 = rectangle(510,75,"outline","black")
   img6 = rectangle(270,510,"outline","black")
   #img7 = circle(50,"outline","black")
   #img8 = triangle(100,"outline","black")

   test-lst = [list: img1, img2, img3, img4, img5, img6,]
   print-imgs(test-lst)
|#
