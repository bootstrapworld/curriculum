use context starter2024
################################################################
# Bootstrap: DataScience 
# Support files, as of Fall 2026

provide *
import starter2024 as Starter 
import constants as Consts
provide from Consts: PI, E end
provide from Starter: expt, sqrt, sqr, abs, random end
include charts
include image
import math as Math
provide from Math:
    * hiding(sum),
  type *,
  data *
end
import statistics as Stats
import sets as Sets
import string-dict as SD
import either as Eth
include error
include constants

import color as C
provide from C:
  type *,
end
import global as Global
import gdrive-sheets as G
provide from G: 
    * hiding(load-spreadsheet),
  type *, 
  data *
end
import tables as T
provide from T:
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

import lists as L
provide from L:
    * hiding(filter, sort, range),
  type *,
  data *
end

# override Pyret's native range (list) with range (stats)
shadow range = lam(t :: Table, col :: String) block:
  l = t.column(col).sort()
  num-to-string-digits(Math.max(l) - Math.min(l), 2)
end

# override Pyret's native translate with put-image
shadow translate = put-image

# override Pyret's native color constructor with make-color
shadow make-color = C.color

# check to ensure that every value is actually a number
is-all-numbers = _.all(is-number)
fun ensure-numbers(l :: List<Number>%(is-all-numbers)): l end

# re-export render-chart
shadow render-chart = render-chart

num-round-to :: (n :: Number, digits :: Number) -> Roughnum
fun num-round-to(n, digits) block:
  num-to-roughnum(num-round(n * num-expt(10, digits)) / num-expt(10, digits))
end

#################################################
# Numerical functions

# round digits to something reasonable
fun round-digits(val, digits):
  num-round(val * num-expt(10, digits)) / num-expt(10, digits)
where:
  round-digits(1.24, 1) is 1.2
  round-digits(num-sqrt(2), 3) is 1.414
end

# allow custom log bases
fun log-base(base, val):
  lg = num-log(val) / num-log(base)
  lg-round = round-digits(lg, 4)
  if roughly-equal(lg-round, lg) and roughly-equal(num-expt(base, lg-round), val):
    lg-round
  else:
    lg
  end
where:
  log-base(3, 9) is 2
  log-base(3, 1/9) is -2
  num-log(9) / num-log(3) satisfies num-is-roughnum
  log-base(4, 32) is 2.5
end


# shortcut alias for log and ln
fun log(n): log-base(10, n) end
ln = num-log

# utility functions
fun fake-num-to-fixnum(n):
  var s = num-to-string(num-to-roughnum(n))
  string-substring(s, 1, string-length(s))
end
fun string-to-number-i(s):
  cases(Option) string-to-number(s):
  | some(n) => n
  | none => -1e100
  end
end

fun make-sci(prefix, underlying-num, underlying-num-str, max-chars):
  # spy "make-sci": prefix, underlying-num, underlying-num-str end
  u-len = string-length(underlying-num-str)
  girth = num-floor(log-base(10, num-abs(underlying-num)))
  # spy 'girth': girth end
  neg-girth = 0 - girth
  decimal-point-position = string-index-of(underlying-num-str, '.')
  int-str = if decimal-point-position > -1:
    string-substring(underlying-num-str, 0, decimal-point-position)
    else: underlying-num-str
    end
  dec-str = if decimal-point-position > -1:
    string-substring(underlying-num-str, decimal-point-position + 1, u-len)
    else: ''
    end
  dec-str-len = string-length(dec-str)
  int-part = if girth >= 0:
    string-substring(int-str, 0, 1) + '.'
    else: string-substring(dec-str, neg-girth - 1, neg-girth) + '.'
    end
  dec-part = if girth >= 0:
    string-substring(int-str, 1, string-length(int-str)) +
                dec-str
    else if neg-girth == dec-str-len: '0'
    else: string-substring(dec-str, neg-girth, dec-str-len)
    end
  expt-part = if girth == 0: ''
              else if girth > 0: 'e' + num-to-string(girth)
              else: 'e-' + num-to-string(neg-girth)
              end
    
  if (string-length(prefix) + string-length(int-part) + 
     string-length(dec-part) + string-length(expt-part)) <= max-chars:
     prefix + int-part  + dec-part   + expt-part
  else:
     shrink-dec(prefix + int-part + dec-part,
       max-chars - (string-length(expt-part))) + expt-part
  end
end
fun make-unsci(prefix, underlying-num-str, u-len):
  # spy 'make-unsci of': prefix, underlying-num-str end
  e-position = string-index-of(underlying-num-str, 'e')
  mantissa-str = string-substring(underlying-num-str, 0, e-position)
  exponent = string-to-number-i(string-substring(
    underlying-num-str, e-position + 1, u-len))
  mantissa-len = string-length(mantissa-str)
  mantissa-decimal-point-position = string-index-of(mantissa-str, '.')
  mantissa-int-str = if mantissa-decimal-point-position > -1:
      string-substring(mantissa-str, 0, mantissa-decimal-point-position)
    else: mantissa-str
    end
  mantissa-frac-str = if mantissa-decimal-point-position > -1:
    string-substring(mantissa-str,
      mantissa-decimal-point-position + 1, mantissa-len)
    else: ''
    end
  if exponent == 0:
    prefix + underlying-num-str
  else if exponent > 0:
    mantissa-frac-len = string-length(mantissa-frac-str)
    if mantissa-frac-len == exponent:
      prefix + mantissa-int-str + mantissa-frac-str
    else if mantissa-frac-len < exponent:
      prefix + mantissa-int-str + mantissa-frac-str +
        string-repeat('0', exponent - mantissa-frac-len)
    else:
      prefix + mantissa-int-str +
        string-substring(mantissa-frac-str, 0, exponent) + '.' +
        string-substring(mantissa-frac-str, exponent, mantissa-frac-len)
    end
  else:
    shadow exponent = 0 - exponent
    mantissa-int-len = string-length(mantissa-int-str)
    if mantissa-int-len == exponent:
      prefix + "0." + mantissa-int-str + mantissa-frac-str
    else if mantissa-int-len < exponent: 
      prefix + "0." + string-repeat('0', (exponent - mantissa-int-len) - 1) +
      mantissa-int-str + mantissa-frac-str
    else:
      prefix +
      string-substring(mantissa-int-str, 0, mantissa-int-len - exponent) +
      "." + 
      string-substring(mantissa-int-str, mantissa-int-len - exponent,
      mantissa-int-len)
    end
  end
end
fun shrink-dec(num-str, max-chars):
  # spy 'shrink-dec of':  num-str end
  decimal-position = string-index-of(num-str, '.')
  len = string-length(num-str)
  if decimal-position <= max-chars: string-substring(num-str, 0, max-chars)
  else: num-str
  end
end
fun num-to-sci(n, max-chars) block:
  # spy: n end
  negativep = (n < 0)
  roughp = num-is-roughnum(n)
  underlying-num = if negativep: 0 - n else: n end
  # spy: underlying-num end
  underlying-num-str = fake-num-to-fixnum(underlying-num)
  # spy: underlying-num-str end
  u-len = string-length(underlying-num-str)
  g-len = (if negativep: 1 else: 0 end) + (if roughp: 1 else: 0 end) + u-len
  prefix = (if roughp: '~' else: '' end) + (if negativep: '-' else: '' end)
  if not(string-contains(underlying-num-str, 'e')): 
    # spy: fixme: 1, g-len, max-chars end
    if g-len <= max-chars: 
      if not(string-contains(underlying-num-str, '/') or
             string-contains(underlying-num-str, '.')):
        num-to-string(n)
      else: prefix + underlying-num-str
      end
    else if num-to-fixnum(underlying-num) == 0: prefix + '0'
    else:
      girth = num-floor(log-base(10, num-abs(underlying-num)))
      # spy: fixme: 2, girth, underlying-num-str end
      sci-num-str = make-sci(prefix, underlying-num, underlying-num-str, 
         max-chars)
      # spy: sci-num-str end
      if (girth < 0) and (girth > -3):
        # spy: fixme: 2.4 end
        shrink-dec(prefix + underlying-num-str, max-chars)
      else if string-length(sci-num-str) <= max-chars: sci-num-str
      else if not(string-contains(underlying-num-str, '/')): 
        shrink-dec(prefix + underlying-num-str, max-chars)
      else:
        # spy: fixme: 3 end
        sci-num-str
      end
    end
  else:
    unsci-num-str = make-unsci(prefix, underlying-num-str, u-len)
    # spy "unsci": prefix, underlying-num-str, unsci-num-str end
    if string-length(unsci-num-str) <= max-chars: unsci-num-str
    else if g-len <= max-chars: prefix + underlying-num-str
    # else: shrink-num(prefix, underlying-num, max-chars)
    else: shrink-dec(prefix + underlying-num-str, max-chars)
    end
  end
where:
  num-to-sci(0.00000343, 10) is "0.00000343" # max fixnum size (small)
  num-to-sci(0.000000343, 11) is "0.00000343"
  num-to-sci(0.00000343, 8) is "3.43e-6"
  num-to-sci(0.00000343, 9) is "3.43e-6"
  num-to-sci(4564634745675734, 16) is "4564634745675734" # max fixnum size (big)
  num-to-sci(45646347456757342, 17) is "45646347456757342"
  num-to-sci(45646347456757342, 16) is "4.56463474567e16"
  num-to-sci(4564634745675734, 15) is "4.5646347456e15" 
  num-to-sci(-45646347456757342.000343, 16) is "-4.5646347456e16"
  num-to-sci(0.000001, 8) is "0.000001"
  num-to-sci(-0.000001, 8) is "-1.0e-6"
  num-to-sci(1/3, 18) is "0.3333333333333333"
  num-to-sci(1/3, 19) is "0.3333333333333333" # extra char is unused due to fixnum precision
  num-to-sci(1/3, 8) is "0.333333"
  num-to-sci(1 + 1/3, 8) is "1.333333"
end
# print(num-to-sci(23e3, 18))

#################################################################################
# Trig functions

TRIG_ROUND_DIGITS = 10

fun rough-round-digits(val, digits):
  num-to-roughnum(num-round(val * num-expt(10, digits)) / num-expt(10, digits))
where:
  rough-round-digits(1.24, 1) is-roughly ~1.2
  rough-round-digits(num-sqrt(2), 3) is-roughly ~1.414
end


shadow sin = lam(n):
  rough-round-digits(num-sin(n), TRIG_ROUND_DIGITS)
end

shadow cos = lam(n):
  rough-round-digits(num-cos(n), TRIG_ROUND_DIGITS)
end

shadow tan = lam(n):
  rough-round-digits(num-tan(n), TRIG_ROUND_DIGITS)
end

check:
  sin(PI) is-roughly 0
  sin(2 * PI) is-roughly 0
  sin(PI / 2) is-roughly 1
  sin((3 * PI) / 2) is-roughly -1
  cos(PI / 3) is-roughly 0.5
  sin(PI / 6) is-roughly 0.5
end


#################################################################################
# Table Functions

# check that the table isn't empty, has all the necessary columns, and contains no blanks
fun check-integrity(t :: Table, cols :: List<String>) block:
  t-cols = t.column-names()
  check-col = lam(c): if t-cols.member(c): nothing
    else: raise(message-exception("'" + c + "' is not a column in this table. Columns are: " + t-cols.join-str(", "))) 
    end
  end
  cols.each(check-col)
  if (t.all-rows().length() == 0):
    raise(message-exception("This table contains no data rows (it's empty!)"))      
  else:
    L.each(lam(c): 
        if is-Option(t.row-n(0)[c]):
          raise(message-exception("This table contains blank cells in column " + c))
        else:
          nothing
        end
      end, 
      t.column-names())
  end
end

# shadow the built-in function, with one naive twist:
# if it looks like a sheets URL, try parsing out the fileID
# for the user. Otherwise, just fall back to the native 
# library function
fun load-spreadsheet(url :: String) block:
  if (string-length(url) < 39):
    G.load-spreadsheet(url)
  else if (string-substring(url, 0, 39) <> "https://docs.google.com/spreadsheets/d/"):
    G.load-spreadsheet(url)
  else:
    rest = string-substring(url, 39, string-length(url))
    G.load-spreadsheet(string-split(rest,"/").get(0))
  end
end


fun live-display(gsheetID :: String, sheet-name :: String, columns :: List<String>, f)  -> Image block:
  fun get-table(t):
    sheet = load-spreadsheet(gsheetID).sheet-by-name(sheet-name, true)
    Global.builtins.open-table(sheet.load(raw-array-from-list(columns), [raw-array: ]))
  end
  r = reactor:
    init: get-table(nothing),
    to-draw: visualize,
    seconds-per-tick: 2,
    on-tick: get-table
  end
  r.interact()
  f(get-table(nothing))
end



# live-survey :: (String, String, List<String> :: (Any -> Image)
fun live-survey(gsheetID, sheet-name, columns, visualize) block:
  live-display(gsheetID, sheet-name, columns, visualize)
end

# Strings, Integers and numbers with 2 decimals are displayed exactly
# more than 2 decimals are displayed as roughnums
fun get-labels(t, ls) block:
  ls-col = t.column(ls)
  if is-number(ls-col.get(0)): 
    ls-col.map(lam(x) block:
        rounded = num-round(x * 100) / 100
        if num-is-integer(x): num-to-string-digits(x, 0)
        else if (x == rounded): num-to-string-digits(x, 2) 
        else: "~" + num-to-string-digits(x, 2) 
        end
      end)
  else:
    ls-col.map(to-repr)
  end
end

# Optimally-distinct list of colors taken from 
# https://stackoverflow.com/a/12224359/12026982
COLORS = [list: 
  C.color(51,102,204, 1), 
  C.color(220,57,18, 1), 
  C.color(255,153,0, 1), 
  C.color(16,150,24, 1), 
  C.color(153,0,153, 1), 
  C.color(0,153,198, 1), 
  C.color(221,68,119, 1), 
  C.color(102,170,0, 1), 
  C.color(184,46,46, 1), 
  C.color(49,99,149, 1), 
  C.color(153,68,153, 1), 
  C.color(34,170,153, 1), 
  C.color(170,170,17, 1), 
  C.color(102,51,204, 1), 
  C.color(230,115,0, 1), 
  C.color(139,7,7, 1), 
  C.color(101,16,103, 1), 
  C.color(50,146,98, 1), 
  C.color(85,116,166, 1), 
  C.color(59,62,172, 1), 
  C.color(183,115,34, 1), 
  C.color(22,214,32, 1), 
  C.color(185,19,131, 1), 
  C.color(244,53,158, 1), 
  C.color(156,89,53, 1), 
  C.color(169,196,19, 1), 
  C.color(42,119,141, 1), 
  C.color(102,141,28, 1), 
  C.color(190,164,19, 1), 
  C.color(12,89,34, 1), 
  C.color(116,52,17, 1)]

# maintain a mutable dict mapping string values to colors, so that any
# categorical display will have the same colors for the same value across
# program-opens (closing and re-opening the program will clear the dict).
var string-colors = [SD.mutable-string-dict:]
var colorIdx = 0

fun nextColor() block:
  if (colorIdx < (COLORS.length() - 1)): 
    colorIdx := colorIdx + 1
  else: colorIdx := 0
  end
  COLORS.get(colorIdx)
end

# Given a table and a column name, extract distinct string values from
# that col and get the associated colors in the string-colors dict. If
# no color is assigned, grab a new one from the colors list and assign it
# Given a table and a column name, extract distinct string values from
# that col and get the associated colors in the string-colors dict. If
# no color is assigned, grab a new one from the colors list and assign it
distinct-colors :: (t :: Table, col :: String) -> Table
fun distinct-colors(t, col):
  t.build-column("color", lam(r) block: 
      key = to-repr(r.get-value(col))
      when not(string-colors.has-key-now(key)): 
        string-colors.set-now(key, nextColor())
      end
      string-colors.get-value-now(key)
    end)
end

fun make-title(str-list):
  fold_n(
    lam(i, acc, str):
      beside(
        acc,
        if num-is-integer(i / 2): text(" " + str + " ", 18, "black")
        else: text-font(str, 16, "blue", "Courier",
    "swiss", "normal", "normal", false)
        end)
    end,
    0,
    text("",18,"black"),
    str-list)
end

## WRAP METHODS IN FUNCTIONS #####################################c
fun row-n(t :: Table, n :: Number) block:
  check-integrity(t, [list: ])
  t.row-n(n)
end


# if the column is a boolean, convert to a number and sort
shadow sort = lam(t :: Table, col :: String, asc :: Boolean):
  if ((t.all-rows().length() > 0) and is-boolean(t.row-n(0)[col])): t.build-column("tmp", lam(r):to-repr(r[col]) end).order-by("tmp", asc).drop("tmp")
  else: t.order-by(col, asc) 
  end
end

shadow filter = lam(t :: Table, fn :: (Row->Boolean)): 
  t.filter(fn) 
end

fun build-column(t :: Table, col :: String, fn :: (Row->Any)): 
  t.build-column(col, fn) 
end

fun transform-column(t :: Table, col :: String, fn :: (Row->Any)): 
  t.transform-column(col, fn) 
end

## CENTER AND SPREAD #############################################
mean :: (t :: Table, col :: String) -> Number
fun mean(t, col) block:
  check-integrity(t, [list: col])
  if not(is-number(t.column(col).get(0))):
    raise(message-exception("Cannot compute the mean, because the specified column does not contain numeric data"))
  else:
    Stats.mean(ensure-numbers(t.column(col))) 
  end
end

median :: (t :: Table, col :: String) -> Number
fun median(t, col) block: 
  check-integrity(t, [list: col])
  if not(is-number(t.column(col).get(0))):
    raise(message-exception("Cannot compute the median, because the specified column does not contain numeric data"))
  else:
    Stats.median(ensure-numbers(t.column(col))) 
  end
end

modes  :: (t :: Table, col :: String) -> List<Number>
fun modes( t, col) block: 
  check-integrity(t, [list: col])
  Stats.modes(t.column(col))
end

shadow sum = lam(t :: Table, col :: String) block: 
  check-integrity(t, [list: col])
  if not(is-number(t.column(col).get(0))):
    raise(message-exception("Cannot compute the sum, because the specified column does not contain numeric data"))
  else:
    Math.sum(ensure-numbers(t.column(col))) 
  end
end

stdev  :: (t :: Table, col :: String) -> Number
fun stdev( t, col) block: 
  check-integrity(t, [list: col])
  if not(is-number(t.column(col).get(0))):
    raise(message-exception("Cannot compute the mean, because the specified column does not contain numeric data"))
  else:
    Stats.stdev-sample(ensure-numbers(t.column(col))) 
  end
end

r-value:: (t :: Table, xs :: String, ys :: String) -> Number
fun r-value(t, xs, ys) block:
  check-integrity(t, [list: xs, ys])
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise("Cannot compute the mean, because the specified columns do not contain numeric data")
  else:
    fn = Stats.linear-regression(
      ensure-numbers(t.column(xs)), 
      ensure-numbers(t.column(ys)))
    dir = if ((fn(1) - fn(0)) < 0): -1 else: 1 end
    dir * num-sqrt(Stats.r-squared(t.column(xs), t.column(ys), fn))
  end
end

## PIE AND BAR CHARTS ###########################################

# given a summary table with columns <col> and "count",
# apply a function <f> to each row and produce the 
# resulting image-list, or a helpful error
fun make-images-from-grouped-rows(summary, col, f):
  cases(Eth.Either) run-task(lam():
          summary.all-rows().map(f)
        end):
    | left(v) => v
    | right(v) => raise(message-exception("The chart you are making can only display 1 image for the all the rows represented in each '" + col + "', so your drawing function must only use the '" + col + "' column"))
  end
end

fun pie-chart-raw(t, ls, vs, column-name) block:
  labels = get-labels(t, ls)
  series = from-list.pie-chart(labels, ensure-numbers(t.column(vs)))
    .colors(t.column("color"))
  img = render-chart(series).get-image()
  title = make-title([list:"Distribution of", column-name])
  above(title, img)
end

# no need to check integrity - all parent functions do it first
fun bar-chart-raw(t, ls, vs, column-name) block:
  labels = get-labels(t, ls)
  series = from-list.bar-chart(labels, ensure-numbers(t.column(vs)))
    .colors(t.column("color"))
  img = render-chart(series)
    .y-axis(vs)
    .y-min(0)
    .get-image()
  title = make-title([list:"Distribution of", column-name])
  above(title, img)
end

# wrappers for raw charts: extract a summary table
# and compute the colors, and display
pie-chart :: (t :: Table, col :: String) -> Image
fun pie-chart(t, col) block:
  check-integrity(t, [list: col])
  title = "Cases for column: '" + col + "'"
  summary = count(t, col)
  color-table = distinct-colors(summary, "value")
  pie-chart-raw(color-table, "value", "count", col)
end

image-pie-chart :: (t :: Table, col :: String, f :: (Row -> Image)) -> Image
fun image-pie-chart(t, col, f) block:
  check-integrity(t, [list: col])
  summary = count(t, col).rename-column("value", col)
  images = make-images-from-grouped-rows(summary, col, f)
  series = from-list.image-pie-chart(
    images,
    get-labels(summary, col), 
    ensure-numbers(summary.column("count")))
  img = render-chart(series)
    .get-image()
  title = make-title([list:"Distribution of", col])
  above(title, img)
end

bar-chart :: (t :: Table, col :: String) -> Image
fun bar-chart(t, col) block:
  check-integrity(t, [list: col])
  summary = count(t, col)
  color-table = distinct-colors(summary, "value")
  bar-chart-raw(color-table, "value", "count", col)
end

image-bar-chart :: (t :: Table, col :: String, f :: (Row -> Image)) -> Image
fun image-bar-chart(t, col, f) block:
  check-integrity(t, [list: col])
  summary = count(t, col).rename-column("value", col)
  images = make-images-from-grouped-rows(summary, col, f)
  series = from-list.image-bar-chart(
    images,
    get-labels(summary, col), 
    ensure-numbers(summary.column("count")))
  img = render-chart(series)
    .y-min(0)
    .get-image()
  title = make-title([list:"Distribution of", col])
  above(title, img)
end

# wrappers for summarized charts: check for numeric
# data, extract the colors, and display
fun pie-chart-summarized(t, ls, vs) block:
  check-integrity(t, [list: ls, vs])
  if not(is-number(t.column(vs).get(0))):
    raise(message-exception("Cannot make a summarized pie chart, because the 'values' column does not contain numeric data"))
  else:
    color-table = distinct-colors(t, ls)
    pie-chart-raw(color-table, ls, vs, ls)
  end
end  

fun bar-chart-summarized(t, ls, vs) block:
  check-integrity(t, [list: ls, vs])
  if not(is-number(t.column(vs).get(0))):
    raise(message-exception("Cannot make a summarized bar chart, because the 'values' column does not contain numeric data"))
  else:
    color-table = distinct-colors(t, vs)
    bar-chart-raw(color-table, ls, vs, ls)
  end
end


stacked-bar-chart :: (t :: Table, col :: String, subcol :: String) -> Image
fun stacked-bar-chart(t, col, subcol) block:
  check-integrity(t, [list: col, subcol])
  shadow segments = Sets.list-to-set(t.get-column(subcol).map(to-repr)).to-list().sort()
  color-list = segments.map(lam(_): nextColor() end)
  tab = group-and-subgroup(t, col, subcol)
  series = from-list.stacked-bar-chart(
      tab.get-column("group").map(to-repr), 
      tab.get-column("data"), 
      segments)
    .stacking-type(percent)
    .colors(color-list)
  img = render-chart(series).get-image()
  title = make-title([list:"Distribution of", subcol, "by", col])
  above(title, img)
end

multi-bar-chart :: (t :: Table, col :: String, subcol :: String) -> Image
fun multi-bar-chart(t, col, subcol) block:
  check-integrity(t, [list: col, subcol])
  shadow segments = Sets.list-to-set(t.get-column(subcol).map(to-repr))
    .to-list().sort()
  color-list = segments.map(lam(_): nextColor() end)
  tab = group-and-subgroup(t, col, subcol)
  series = from-list.grouped-bar-chart(
      tab.get-column("group").map(to-repr), 
      tab.get-column("data"), 
      segments)
    .colors(color-list)
  img = render-chart(series).get-image()
  title = make-title([list:"Distribution of", subcol, "by", col])
  above(title, img)
end



## DOT PLOTS #############################################


dot-plot :: (t :: Table, col :: String) -> Image
fun dot-plot(t, col) block:
  check-integrity(t, [list: col])
  summary = count(t, col).rename-column("value", col)
  categoryCount = ensure-numbers(summary.column("count"))
  
  # 
  fun height(width): (width * Math.max(categoryCount)) / categoryCount.length() end
  
  SIZE = 400
  DOT = overlay(
    ellipse(SIZE, height(SIZE), "solid", C.color(51,102,204, 1)),
    rectangle(SIZE, height(SIZE) + 5, "solid", "transparent"))

  images = categoryCount.map(lam(n): 
      above-list(L.range(0,n).map(lam(x): DOT end))
    end)
  series = from-list.image-bar-chart(
    images,
    get-labels(summary, col), 
    ensure-numbers(summary.column("count")))
  img = render-chart(series)
    .y-min(0)
    .get-image()
  title = make-title([list:"Distribution of", col])
  above(title, img)
end

## HISTOGRAMS #############################################
simple-histogram :: (t :: Table, vals :: String, bin-width :: Number) -> Image
fun simple-histogram(t, vals, bin-width) block:
  doc: "wrap histogram so that the bin-width is set"
  check-integrity(t, [list: vals])
  if not(is-number(t.column(vals).get(0))):
    raise(message-exception("Cannot make a histogram, because the '" + vals + "' column does not contain quantitative data"))
  else:
    img = render-chart(from-list.histogram(ensure-numbers(t.column(vals))).bin-width(bin-width))
      .x-axis(vals)
      .y-axis("count")
      .get-image()
    title = make-title([list:"Distribution of", vals])
    above(title, img)
  end
end

histogram :: (t :: Table, labels :: String, vals :: String, bin-width :: Number) -> Image
fun histogram(t, labels, vals, bin-width) block:
  doc: "wrap histogram so that the bin-width is set"
  check-integrity(t, [list: labels, vals])
  if not(is-number(t.column(vals).get(0))):
    raise(message-exception("Cannot make a histogram, because the '" + vals + "' column does not contain quantitative data"))
  else:
    img = render-chart(from-list.labeled-histogram(
        t.column(labels).map(to-repr),
        ensure-numbers(t.column(vals))).bin-width(bin-width))
      .x-axis(vals)
      .y-axis("count")
      .get-image()
    title = make-title([list:"Distribution of", vals])
    above(title, img)
  end
end

image-histogram :: (t :: Table, vals :: String, bin-width :: Number, f :: (Row -> Image)) -> Image
fun image-histogram(t, vals, bin-width, f) block:
  check-integrity(t, [list: vals])
  images = t.all-rows().map(f)
  if not(is-number(t.column(vals).get(0))):
    raise(message-exception("Cannot make a histogram, because the '" + vals + "' column does not contain quantitative data"))
  else:
    img = render-chart(from-list.image-histogram(images, ensure-numbers(t.column(vals))).bin-width(bin-width))
      .x-axis(vals)
      .y-axis("count")
      .get-image()
    title = make-title([list:"Distribution of", vals])
    above(title, img)
  end
end

scaled-histogram :: (t :: Table, vals :: String, bin-width :: Number, low :: Number, high :: Number) -> Image
fun scaled-histogram(t, vals, bin-width, low, high) block:
  doc: "wrap histogram so that the bin-width is set"
  check-integrity(t, [list: vals])
  if not(is-number(t.column(vals).get(0))):
    raise(message-exception("Cannot make a histogram, because the '" + vals + "' column does not contain quantitative data"))
  else:
    img = render-chart(from-list.histogram(ensure-numbers(t.column(vals))).bin-width(bin-width))
      .x-axis(vals)
      .y-axis("count")
      .min(low).max(high)
      .get-image()
    title = make-title([list:"Distribution of", vals])
    above(title, img)
  end
end



## BOX PLOTS #############################################

fun minimum(t :: Table, col :: String) block:
  check-integrity(t, [list: col])
  if not(is-number(t.column(col).get(0))):
    raise(message-exception("Cannot compute the minimum, because the '" + col + "' column does not contain quantitative data"))
  else:
    Math.min(t.column(col))
  end
end

fun maximum(t :: Table, col :: String) block:
  check-integrity(t, [list: col])
  if not(is-number(t.column(col).get(0))):
    raise(message-exception("Cannot compute the maximum, because the '" + col + "' column does not contain quantitative data"))
  else:
    Math.max(t.column(col))
  end
end

fun iqr(t :: Table, col :: String) block:
  check-integrity(t, [list: col])
  l = t.column(col).sort()
  first-half = l.split-at(num-floor(l.length() / 2)).prefix
  second-half = l.split-at(num-ceiling(l.length() / 2)).suffix
  num-to-string-digits(Stats.median(second-half) - Stats.median(first-half),2)
end
fun IQR(t, col): iqr(t, col) end

fun get-5-num-summary(t :: Table, col :: String) block:
  check-integrity(t, [list: col])
  l = t.column(col)
  shadow l = l.sort()
  first-half = l.split-at(num-floor(l.length() / 2)).prefix
  second-half = l.split-at(num-ceiling(l.length() / 2)).suffix
  shadow minimum = num-to-string-digits(Math.min(l), 2)
  Q1 = num-to-string-digits(Stats.median(first-half), 2)
  Q2 = num-to-string-digits(Stats.median(l), 1)
  Q3 = num-to-string-digits(Stats.median(second-half), 2)
  shadow maximum = num-to-string-digits(Math.max(l), 2)
  R = num-to-string-digits(Math.max(l) - Math.min(l), 2)
  [list: "Min:", minimum, ",  Q1:", Q1, ",  Median:", Q2, ",  Q3:", Q3, ",  Max:", maximum].join-str("")
end

box-plot-raw :: (t :: Table, vs :: String, low :: Number, high :: Number, horizontal :: Boolean, showOutliers :: Boolean) -> Image
fun box-plot-raw(t, vs, low, high, horizontal, showOutliers) block:
  l = ensure-numbers(t.column(vs))
  if not(is-number(l.get(0))):
    raise(message-exception("Cannot make a box plot, because the 'values' column does not contain numeric data"))
  else if (low > high):
    raise(message-exception("Min value must be lower than Max value"))
  else:
    series = from-list.labeled-box-plot([list: vs], [list: l])
      .horizontal(horizontal).show-outliers(showOutliers)
      .color(make-color(0,0,100,1))
    img = render-chart(series)
      .title(get-5-num-summary(t, vs))
      .min(low).max(high)
      .get-image()
    title = make-title([list:"Distribution of", vs])
    above(title, img)
  end
end

box-plot :: (t :: Table, vs :: String) -> Image
# pass the min as 0 and the max as the largest value in the column
fun box-plot(t, vs) block:
  check-integrity(t, [list: vs])
  lo = Math.min(t.column(vs))
  hi = Math.max(t.column(vs))
  box-plot-raw(t, vs, lo, hi, true, false)
end

box-plot-scaled :: (t :: Table, vs :: String, lo :: Number, hi :: Number) -> Image
fun box-plot-scaled(t, vs, lo, hi) block:
  check-integrity(t, [list: vs])
  box-plot-raw(t, vs, lo, hi, true, false)
end

modified-box-plot :: (t :: Table, vs :: String) -> Image
fun modified-box-plot(t, vs) block:
  check-integrity(t, [list: vs])
  lo = Math.min(t.column(vs))
  hi = Math.max(t.column(vs))
  box-plot-raw(t, vs, lo, hi, true, true)
end

modified-box-plot-scaled :: (t :: Table, vs :: String, lo :: Number, hi :: Number) -> Image
fun modified-box-plot-scaled(t, vs, lo, hi) block:
  check-integrity(t, [list: vs])
  box-plot-raw(t, vs, lo, hi, true, true)
end

vert-box-plot :: (t :: Table, vs :: String) -> Image
fun vert-box-plot(t, vs) block:
  check-integrity(t, [list: vs])
  lo = Math.min(t.column(vs))
  hi = Math.max(t.column(vs))
  box-plot-raw(t, vs, lo, hi, false, false)
end

modified-vert-box-plot :: (t :: Table, vs :: String) -> Image
fun modified-vert-box-plot(t, vs) block:
  check-integrity(t, [list: vs])
  lo = Math.min(t.column(vs))
  hi = Math.max(t.column(vs))
  box-plot-raw(t, vs, lo, hi, false, true)
end

modified-vert-box-plot-scaled :: (t :: Table, vs :: String, lo :: Number, hi :: Number) -> Image
fun modified-vert-box-plot-scaled(t, vs, lo, hi) block:
  check-integrity(t, [list: vs])
  box-plot-raw(t, vs, lo, hi, false, true)
end

## LINE GRAPHS ######################################################
line-graph :: (t :: Table, labels :: String, xs :: String, ys :: String) -> Image
fun line-graph(t, labels, xs, ys) block:
  check-integrity(t, [list: xs, ys])
  l = ensure-numbers(t.column(xs))
  l2 = ensure-numbers(t.column(ys))
  ls = get-labels(t, labels)
  sorted = t.order-by(xs, true) # sort the table by x-axis
  img = render-chart(from-list.labeled-line-plot(ls, sorted.column(xs), sorted.column(ys)))
    .x-axis(xs)
    .y-axis(ys)
    .get-image()
  title = make-title([list:"", ys, "vs.", xs])
  above(title, img)
end


## LR AND SCATTER PLOTS #############################################
scatter-plot :: (t :: Table, labels :: String, xs :: String, ys :: String) -> Image
fun scatter-plot(t, labels, xs, ys) block:
  check-integrity(t, [list: labels, xs, ys])
  ls = get-labels(t, labels)
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise(message-exception("Cannot make a scatter plot, because the 'xs' and 'ys' columns must both contain numeric data"))
  else:
    img = render-chart(from-list.labeled-scatter-plot(ls, ensure-numbers(t.column(xs)), ensure-numbers(t.column(ys))))
      .x-axis(xs)
      .y-axis(ys)
      .get-image()
  title = make-title([list:"", ys, "vs.", xs])
  above(title, img)
  end
end

simple-scatter-plot :: (t :: Table, xs :: String, ys :: String) -> Image
fun simple-scatter-plot(t, xs, ys) block:
  check-integrity(t, [list: xs, ys])
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise(message-exception("Cannot make a scatter plot, because the 'xs' and 'ys' columns must both contain numeric data"))
  else:
    img = render-chart(from-list.scatter-plot(ensure-numbers(t.column(xs)), ensure-numbers(t.column(ys))))
      .x-axis(xs)
      .y-axis(ys)
      .get-image()
    title = make-title([list:"", ys, "vs.", xs])
    above(title, img)
  end
end

image-scatter-plot :: (t :: Table, xs :: String, ys :: String, f :: (Row -> Image)) -> Image
fun image-scatter-plot(t, xs, ys, f) block:
  check-integrity(t, [list: xs, ys])
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise(message-exception("Cannot make an image scatter plot, because the 'xs' and 'ys' columns must both contain numeric data"))
  else:
    images = t.all-rows().map(f)
    img = render-chart(from-list.image-scatter-plot(images, ensure-numbers(t.column(xs)), ensure-numbers(t.column(ys))))
      .x-axis(xs)
      .y-axis(ys)
      .get-image()
  title = make-title([list:"", ys, "vs.", xs])
  above(title, img)
  end
end


multiple-regression :: (
  t :: Table, 
  explanations :: List<String>, 
  response :: String) -> 
(List<Number> -> Number)
fun multiple-regression(t, explanations, response):
  # convert the table to a list of rows, then each row to a list of values
  if explanations.length() > t.length():
      raise(message-exception("This data set contains too few data samples and too many independent variables to produce a unique regression.  If all the independent variables are needed, you'll need to collect more data samples; otherwise, try removing ones that aren't relevant"))
      else:
      explanation-lists = t.all-rows().map(
        lam(r): explanations.map(lam(exp): r[exp] end) end)
      response-list = t.column(response)
      Stats.multiple-regression(explanation-lists, response-list)
  end
  #"The Statistics module does not currently provide a multiple-regression function"
end

lr-plot :: (t :: Table, ls :: String, xs :: String, ys :: String) -> Image
fun lr-plot(t, ls, xs, ys) block:
  check-integrity(t, [list: ls, xs, ys])
  labels = get-labels(t, ls)
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise(message-exception("Cannot make an lr-plot, because the 'xs' and 'ys' columns must both contain numeric data"))
  else:
    scatter = from-list.labeled-scatter-plot(labels, ensure-numbers(t.column(xs)), ensure-numbers(t.column(ys)))
      .legend("Data")
    fn = Stats.linear-regression(t.column(xs), t.column(ys))
    fn-plot = from-list.function-plot(fn)
      .legend("Model")
    slope = if ((fn(1) - fn(0)) < 0): "-" else: "+" end
    r-sqr-str = num-to-sci(num-round-to(Stats.r-squared(t.column(xs), t.column(ys), fn), 3), 6)
    r-str = num-to-sci(num-round-to(num-sqrt(Stats.r-squared(t.column(xs), t.column(ys), fn)), 3), 6)
    alpha-str = num-to-sci(fn(2) - fn(1), 9)
    beta-str = (if (fn(0) >= 0): " + " else: "" end) + num-to-sci(fn(0), 9)
    S-str     = num-to-sci(S(t, xs, ys, fn), 9)
    title-str = "y = " + alpha-str + "x" + beta-str + ";    " + "r: " + slope + r-str + ";    r²: " + r-sqr-str + "; S: " + S-str
    img = render-charts([list: scatter, fn-plot]).title(title-str)
      .x-axis(xs)
      .y-axis(ys)
      .get-image()
    title = make-title([list:"", ys, "vs.", xs])
    above(title, img)
  end
end

simple-lr-plot :: (t :: Table, xs :: String, ys :: String) -> Image
fun simple-lr-plot(t, xs, ys) block:
  check-integrity(t, [list: xs, ys])
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise(message-exception("Cannot make an lr-plot, because the 'xs' and 'ys' columns must both contain numeric data"))
  else:
    scatter = from-list.scatter-plot(
      ensure-numbers(t.column(xs)), 
      ensure-numbers(t.column(ys)))
    fn = Stats.linear-regression(t.column(xs), t.column(ys))
    fn-plot = from-list.function-plot(fn)
    slope = if ((fn(1) - fn(0)) < 0): "-" else: "+" end
    r-sqr-str = num-to-sci(Stats.r-squared(t.column(xs), t.column(ys), fn), 7)
    r-str = num-to-sci(num-sqrt(Stats.r-squared(t.column(xs), t.column(ys), fn)), 7)
    alpha-str = num-to-sci(fn(2) - fn(1), 7)
    beta-str = (if (fn(0) >= 0): "+" else: "" end) + num-to-sci(fn(0), 7)
    S-str     = num-to-sci(S(t, xs, ys, fn), 7)
    title-str = "y=" + alpha-str + "x" + beta-str + ";    " + "r: " + slope + r-str + ";    r-sqr: " + r-sqr-str + "; S: " + S-str
    img = render-charts([list: scatter, fn-plot]).title(title-str)
      .x-axis(xs)
      .y-axis(ys)
      .get-image()
    title = make-title([list:"", ys, "vs.", xs])
    above(title, img)
  end
end

image-lr-plot :: (t :: Table, xs :: String, ys :: String, f :: (Row -> Image)) -> Image
fun image-lr-plot(t, xs, ys, f) block:
  check-integrity(t, [list: xs, ys])
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise(message-exception("Cannot make an image-lr-plot, because the 'xs' and 'ys' columns must both contain numeric data"))
  else:
    images = t.all-rows().map(f)
    scatter = from-list.image-scatter-plot(
      images, 
      ensure-numbers(t.column(xs)), 
      ensure-numbers(t.column(ys)))
      .legend("Data")
    fn = Stats.linear-regression(t.column(xs), t.column(ys))
    fn-plot = from-list.function-plot(fn)
      .legend("Model")
    slope = if ((fn(1) - fn(0)) < 0): "-" else: "+" end
    r-sqr-str = num-to-sci(Stats.r-squared(t.column(xs), t.column(ys), fn), 7)
    r-str = num-to-sci(num-sqrt(Stats.r-squared(t.column(xs), t.column(ys), fn)), 7)
    alpha-str = num-to-sci(fn(2) - fn(1), 7)
    beta-str = (if (fn(0) >= 0): "+" else: "" end) + num-to-sci(fn(0), 7)
    S-str     = num-to-sci(S(t, xs, ys, fn), 7)
    title-str = "y=" + alpha-str + "x" + beta-str + ";    " + "r: "  + r-str + ";    r-sqr: " + r-sqr-str + "; S: " + S-str
    img = render-charts([list: scatter, fn-plot]).title(title-str)
      .x-axis(xs)
      .y-axis(ys)
      .get-image()
    title = make-title([list:"", ys, "vs.", xs])
    above(title, img)
  end
end

residuals :: (t :: Table, xs :: String, ys :: String, fn :: (Number -> Number)) -> List<Number>
fun residuals(t, xs, ys, fn) block:
  check-integrity(t, [list: xs, ys])
  if not(is-number(t.column(xs).get(0)) and is-number(t.column(ys).get(0))):
    raise(message-exception("Cannot calculate residuals, because the 'xs' and 'ys' columns must both contain numeric data"))
  else:
    map2(
      lam(y, prediction): y - prediction end, 
      t.column(ys), 
      map(fn, t.column(xs)))
  end
end

S :: (t :: Table, xs :: String, ys :: String, fn :: (Number -> Number)) -> Number
fun S(t, xs, ys, fn) block:
  check-integrity(t, [list: xs, ys])
  datapoints = t.column(xs).length()
  if (datapoints <= 2):
    raise(message-exception("Cannot calculate S for this model and function, because a model with two parameters requires a table with at least 3 rows"))
  else:
    residuals-sqr = residuals(t,xs,ys,fn).map(num-sqr)
    degrees-of-freedom = datapoints - 2
    num-sqrt(Math.sum(residuals-sqr) / degrees-of-freedom)
  end
end

fit-model :: (t :: Table, ls :: String, xs :: String, ys :: String, fn :: (Number -> Number)) -> Image
fun fit-model(t, ls, xs, ys, fn) block:
  check-integrity(t, [list: ls, xs, ys])
  labels = get-labels(t, ls)
  
  # the line below calls S, which does our error-checking
  S-value     = S(t, xs, ys, fn)
  R-sqr-value = Stats.r-squared(t.column(xs), t.column(ys), fn)
  S-str       = num-to-sci(S-value, 10)
  #r-str       = if (R-sqr-value > 0): num-to-sci(num-sqrt(R-sqr-value)) else: "N/A" end
  r-sqr-str   = num-to-sci(R-sqr-value, 8)

  scatter = from-list.labeled-scatter-plot(
    labels, 
    ensure-numbers(t.column(xs)), 
    ensure-numbers(t.column(ys)))
    .legend("Data")
    .point-size(5)
  fn-plot = from-list.function-plot(fn)
    .legend("Model")
  intervals = from-list.interval-chart(
    t.column(xs), 
    t.column(ys), 
    residuals(t, xs, ys, fn))
    .point-size(1)
    .pointer-color(C.green)
    .lineWidth(10)
    .color(C.black)
    .style("sticks")
    .legend("Residuals")
  title-str = "S: " + S-str + ", R-sqr: " + r-sqr-str
  img = render-charts([list: fn-plot, scatter, intervals])
    .title(title-str)
    .x-axis(xs)
    .y-axis(ys)
    .get-image()
  title = make-title([list:"", ys, "vs.", xs])
  above(title, img)
end


## OUTLIER TOOLS ##########################################
q1 :: (t :: Table, col :: String) -> Number
fun q1(t, col) block:
  check-integrity(t, [list: col])
  values = t.get-column(col).sort()
  first-half = values.split-at(num-floor(values.length() / 2)).prefix
  Stats.median(first-half)
end

q3 :: (t :: Table, col :: String) -> Number
fun q3(t, col) block:
  check-integrity(t, [list: col])
  values = t.get-column(col).sort()
  second-half = values.split-at(num-ceiling(values.length() / 2)).suffix
  Stats.median(second-half)
end

compute-outliers :: (t :: Table, col :: String) -> Table
# consumes a table and a column, calculates both the lower boundary and upper boundary (fences), creates a new column called "is-outler" that is populated with "low", "high" and "no"
# (Credit to Jennifer Braun, CSPdWeek 2019)
fun compute-outliers(t, col) block:
  check-integrity(t, [list: col])
  lower-boundary = q1(t, col) - (1.5 * (q3(t, col) - q1(t, col)))
  upper-boundary = q3(t, col) + (1.5 * (q3(t, col) - q1(t, col)))
  t.build-column("is-outlier", 
    (lam(r): 
        ask:
          | (r[col] < lower-boundary) then: "low"
          | (r[col] > upper-boundary) then: "high"
          | otherwise: "no"
        end
      end))
end


outliers :: (t :: Table, col :: String) -> Table
# consumes a table and a column, and returns a table for which every row is an outlier
# (for that column)
fun outliers(t, col):
  compute-outliers(t, col).filter(lam(r): r["is-outlier"] <> "no" end).drop("is-outlier")
end

remove-outliers :: (t :: Table, col :: String) -> Table
# consumes a table and a column, calculates both the lower boundary and upper boundary (fences), and removes any rows that are beyond the fence
# (Credit to Jennifer Braun, CSPdWeek 2019)
fun remove-outliers(t, col):
  compute-outliers(t, col)
    .filter(lam(r): r["is-outlier"] == "no" end)
    .drop("is-outlier")
end

## INFERENCE ##########################################

pop-variance :: (t :: Table, col :: String) -> Number
fun pop-variance(t, col) block:
  check-integrity(t, [list: col])
  _mean = mean(t, col)
  shadow t = t.build-column("sq-diff", lam(r): num-sqr(r[col] - _mean) end)
  sum(t, "sq-diff") / t.length()
end

sample-variance :: (t :: Table, col :: String) -> Number
# sample variance for ungrouped data
fun sample-variance(t, col) block:
  check-integrity(t, [list: col])
  _mean = mean(t, col)
  shadow t = t.build-column("sq-diff", lam(r): num-sqr(r[col] - _mean) end)
  sum(t, "sq-diff") / (t.length() - 1)
end


#|
height = table: player, inches
  row: "RJ Barrett", 78
  row: "Jusuf Nurkic", 84
  row: "James Harden", 77
  row: "Rodney Hood", 80
  row: "Jae'Sean Tate", 76
  row: "Nikola Jokic", 83
  row: "E'Twaun Moore", 76
  row: "Dario Saric", 82
  row: "Tim Frazier", 73
  row: "Brad Wanamaker", 75
end
examples:
  pop-variance(height, "inches") is 12.24
  sample-variance(height, "inches") is 13.6
end

  
paired-t :: (t :: Table, col1 :: String, col2 :: String) -> Number
fun paired-t(t, col1, col2) block:
  check-integrity(t, [list: col1, col2])
  shadow t = t.build-column("diff", lam(r): r[col2] - r[col1] end)
  mean1 = mean(t, col1)
  mean2 = mean(t, col2)
  sdiff = stdev(t, "diff")
  n = t.length()
  df = n - 1
  (mean1 - mean2) / (sdiff / num-sqr(n))
end

eq-variance-t :: (t :: Table, col1 :: String, col2 :: String) -> Number
fun eq-variance-t(t, col1, col2) block:
  check-integrity(t, [list: col1, col2])
  shadow t = t.build-column("diff", lam(r): r[col2] - r[col1] end)
  mean1 = mean(t, col1)
  mean2 = mean(t, col2)
  var1 = sample-variance(t, col1)
  var2 = sample-variance(t, col2)
  n1 = t.length()
  n2 = t.length()
  (mean1 - mean2) / num-sqrt((var1 / n1) + (var2 / n2)) 
end

uneq-variance-t :: (t :: Table, col1 :: String, col2 :: String) -> Number
fun uneq-variance-t(t, col1, col2) block:
  check-integrity(t, [list: col1, col2])
  shadow t = t.build-column("diff", lam(r): r[col2] - r[col1] end)
  mean1 = mean(t, col1)
  mean2 = mean(t, col2)
  var1 = sample-variance(t, col1)
  var2 = sample-variance(t, col2)
  n1 = t.length()
  n2 = t.length()
  df = n1 + n2 + -2
  dfs-and-sq-vars = (((n1 - 1) * num-sqr(var1)) + ((n2 - 1) * num-sqr(var2)))
  (mean1 - mean2) / ((dfs-and-sq-vars / df) * num-sqrt((1 / n1) + (1 / n2))) 
end

|#

## TABLE MUNGING ########################################
row-id :: (t :: Table, id :: String) -> Row
fun row-id(t, id):
  id-col = t.column-names().get(0)
  matching-rows = t.filter(lam(r): r[id-col] == id end)
  if (matching-rows.length() > 1):
    raise(message-exception("The identifier column should contain unique IDs, but this ID matched more than one row"))
  else if (matching-rows.length() == 0) :
    raise(message-exception("No rows have this ID in their identifier column (did you check spelling and capitalization?"))
  else: matching-rows.row-n(0)
  end
end

split-and-reduce :: (
  t :: Table, 
  col-to-split :: String, 
  col-to-reduce :: String,
  reducer :: (Table, String -> Any)
  ) -> Table
fun split-and-reduce(t, col-to-split, col-to-reduce, reducer) block:
  split = group(t, col-to-split)
  cases(Eth.Either) run-task(lam():
          split.build-column(
            "result", 
            {(r): reducer(r["subtable"], col-to-reduce)})
        end):
    | left(v) => v
    | right(v) => raise(message-exception("An error occurred when trying to use your reducer. Are you sure it consumes *only* a valid Table and column name?",v))
  end.drop("subtable")
end

first-n-rows :: (t :: Table, n :: Number) -> Table
fun first-n-rows(t, n):
  T.table-from-rows.make(raw-array-from-list(t.all-rows().take(n)))
end

fun group(tab, col):
  values = Sets.list-to-list-set(tab.get-column(col)).to-list()
  for fold(shadow grouped from table: value, subtable end, v from values):
    grouped.stack(table: value, subtable
        row: v, tab.filter-by(col, {(val): val == v})
      end)
  end
end

fun count(tab, col):
  g = group(tab, col).build-column("count", {(r): r["subtable"].length()}).drop("subtable")
  if is-boolean(g.column("value").get(0)): g
  else: order g: value ascending end
  end
end

fun count-many(tab, cols):
  for fold(shadow grouped from table: col, subtable end, c from cols):
    grouped.stack(table: col, subtable
        row: c, count(tab, c)
      end)
  end
end

fun group-and-subgroup(t :: Table, col :: String, subcol :: String) block:
  subgroups = Sets.list-to-set(t.get-column(subcol))
  tab = group(t, col)
    .rename-column("value", "group")
    .build-column(
    "data", 
    # take a count of the subgroups, then see which subgroups are missing
    # for each one, add a row with a count of zero. Then order the rows
    # and extract the count as a list
    lam(r) block: 
      segments = count(r["subtable"], subcol)
      missing = subgroups.difference(Sets.list-to-set(segments.get-column("value")))
      missing.fold(
        lam(table, subgroup): 
          table.add-row([T.raw-row: {"value"; subgroup}, {"count"; 0}])
        end,
        segments)
        .build-column("sortable", lam(shadow r): to-repr(r["value"]) end)
        .order-by("sortable", true)
        .get-column("count")
    end)
  # sort groups alphabetically
  sort(tab, "group", true)
end


# stack-tables :: Table, Table -> Table
fun stack-tables(t1 :: Table, t2 :: Table) -> Table:
  t1.stack(t2)
end


# pivot-row :: r :: Row -> Table
fun pivot-row(r) block:

  # get-val :: (col :: String) -> Any
  fun get-val(col): r[col] end

  columns = r.get-column-names()
  values = columns.map(get-val)
  [T.table-from-columns:
    {"labels"; columns},
    {"values"; values}
  ]
end

fun make-sample-selections(n :: Number, u :: Number) -> {Boolean; SD.StringDict<Boolean>} block:
  doc: ```
       Key idea: build a dictionary that's either "positive" (keep these keys)
       or "negative" (drop these keys). Do this according to if we want most
       of the keys to stay (use a negative map) or most to go (use a positive
       map). There isn't a good, fast way to remove from a table by index right
       now, so this plus filter is best and actually reasonably performant.
       ```
  when n > u:
    raise(message-exception("make-sample-selections: num-samples too large"))
  end
  fun help(num-samples-remaining-to-get, dict-so-far):
    if num-samples-remaining-to-get == 0: dict-so-far
    else:
      r = num-random(u)
      k = num-to-string(r)
      if dict-so-far.has-key(k):
        help(num-samples-remaining-to-get, dict-so-far)
      else:
        updated = dict-so-far.set(k, true)
        help(num-samples-remaining-to-get - 1, updated)
      end
    end
  end
  if n < (u / 2):
    {true; help(n, [SD.string-dict:])}
  else:
    {false; help(u - n, [SD.string-dict:])}
  end
end

fun filter-n(tabl, pred):
  var i = 0
  tabl.filter(lam(x) block:
      result = pred(i, x)
      i := i + 1
      result
    end)
end

fun random-rows(t, n):
  doc: ```
       if n <<< t.length(), it would be good to sample the rows with row-n and
       build up a table from that rather than doing this process, which is linear
       in the universe size. if n is a proportional to t.length(),
       then this works pretty well.
       ```
  {keep; to-change} = make-sample-selections(n, t.length())
  filter-n(t, lam(index, _):
      k = to-string(index)
      #| could also be written keep == to-change.has-key(k),
      but I find that difficult to grok |#
      if keep: to-change.has-key(k)
      else: not(to-change.has-key(k))
      end
    end)
end

fun make-random-table(num-rows) block:
  var t = table: a end
  for each(i from L.range(0, num-rows)):
    t := t.add-row(t.row(num-random(num-rows)))
  end
  t
end

fun row-to-list(r):
  r.get-column-names().map(r[_])
end

###########################################################################
# GRAPHING AND TABLE FUNCTIONS

function-plot :: (f :: (Number -> Number)) -> Image
fun function-plot(f):
  render-chart(from-list.function-plot(f))
    .x-axis("x")
    .y-axis("y")
    .get-image()
end

def-to-table :: (start :: Number, stop :: Number, f :: (Number -> Number)) -> Table
# Consumes x1, x2, step-size, and the name of a function, and produces an x/y table
fun def-to-table(start, stop, f):
  xs = L.range-by(start, stop + 1, ((stop + 1) - start) / 50)
  ys = xs.map(f)
  [T.table-from-columns: {"x"; xs}, {"y"; ys}]
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
    .get-image()
end

table-to-graph :: (t :: Table) -> Image
# Consumes a table, and makes a line-plot from the first 2 columns
fun table-to-graph(t) block:
  check-integrity(t, [list: "x", "y"])
  cols = t.column-names()
  if (cols.length() < 2): raise(message-exception("The table must have at least two columns"))
  else: 
    xs = t.column(cols.get(0))
    ys = t.column(cols.get(1))
    chart = render-chart(from-list.line-plot(xs, ys))
      .x-axis(cols.get(0))
      .y-axis(cols.get(1))
      .x-min(num-round(Math.min(xs)))
      .x-max(num-round(Math.max(xs)))
    if num-round(Math.min(ys)) == num-round(Math.max(ys)):
      chart.get-image()
    else:
      chart
        .y-min(num-round(Math.min(ys)))
        .y-max(num-round(Math.max(ys)))
        .get-image()
    end
  end
end


# Given a size, produce a normal distribution of that size 
# between 0-1 using  Box Muller transform described at
# https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform
random-normal-distribution :: (size :: Number) -> List<Number>
fun random-normal-distribution(size) block:
  fun box-muller() block:
    u = (random(100) + 1) / 101
    v = (random(100) + 1) / 101
    num = num-sqrt(-2 * num-log(u)) * num-cos( 2.0 * PI * v )
    (num / 10) + 0.5 # divide and shift to cover (0,1)
  end
  L.range(1, size).map(lam(_): box-muller() end)
end


#####################################################################
# used by shapes starter file
draw-shape :: Row -> Image
fun draw-shape(r): 
  if r["name"] == "ellipse": ellipse(50, 100, "solid", r["color"])
  else if r["name"] == "circle": circle(50, "solid", r["color"])
  else: regular-polygon(30, r["corners"], "solid", r["color"])
  end
end
