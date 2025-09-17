use context starter2024
################################################################
# Bootstrap: DataScience 
# Support files, as of Fall 2024

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
  num-to-roughnum(num-round(n * expt(10, digits)) / expt(10, digits))
end

#################################################
# Numerical functions

# round digits to something reasonable
fun round-digits(val, digits):
  num-round(val * expt(10, digits)) / expt(10, digits)
where:
  round-digits(1.24, 1) is 1.2
  round-digits(num-sqrt(2), 3) is 1.414
end

# allow custom log bases
fun log-base(base, val):
  lg = num-log(val) / num-log(base)
  lg-round = round-digits(lg, 4)
  if roughly-equal(lg-round, lg) and roughly-equal(expt(base, lg-round), val):
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
fun fake-num-to-fixnum(n) block:
  var s = num-to-string(num-to-roughnum(n))
  var len = string-length(s)
  s := string-substring(s, 1, len)
  len := len - 1
  expt-position = string-index-of(s, 'e')
  if expt-position == -1: s
  else:
    if string-substring(s, expt-position + 1, expt-position + 2) == '+':
      string-substring(s, 0, expt-position) + string-substring(s, expt-position + 2, len)
    else: s
    end
  end
end

fun fake-num-to-fixnum-no-exp(n):
  make-unsci(fake-num-to-fixnum(n))
end

fun string-to-number-i(s):
  cases(Option) string-to-number(s):
  | some(n) => n
  | none => -1e100
  end
end

fun get-girth(n):
  if n == 0: 0
  else: num-floor(log-base(10, num-abs(n)))
  end
end

fun make-sci(underlying-num, underlying-num-str, max-chars) block:
  # spy "make-sci": underlying-num, underlying-num-str, max-chars end
  underlying-num-str-len = string-length(underlying-num-str)
  girth = num-floor(log-base(10, num-abs(underlying-num)))
  neg-girth = 0 - girth
  # spy 'girth': girth, neg-girth end
  decimal-point-position = string-index-of(underlying-num-str, '.')
  int-str = if decimal-point-position > -1:
    string-substring(underlying-num-str, 0, decimal-point-position)
    else: underlying-num-str
    end
  dec-str = if decimal-point-position > -1:
    string-substring(underlying-num-str, decimal-point-position + 1, underlying-num-str-len)
    else: ''
    end
  # spy: int-str, dec-str end
  dec-str-len = string-length(dec-str)
  int-part = if (girth > 0) and (girth < max-chars): int-str + '.'
    else if girth >= 0:
    string-substring(int-str, 0, 1) + '.'
    else: string-substring(dec-str, neg-girth - 1, neg-girth) + '.'
    end
  dec-part = if (girth > 0) and (girth < max-chars): dec-str
    else if girth >= 0:
    string-substring(int-str, 1, string-length(int-str)) +
                dec-str
    else if neg-girth == dec-str-len: '0'
    else: string-substring(dec-str, neg-girth, dec-str-len)
    end
  expt-part = if (girth > 0) and (girth < max-chars): ''
              else if girth == 0: ''
              else if girth > 0: 'e' + num-to-string(girth)
              else: 'e-' + num-to-string(neg-girth)
              end
  # spy: int-part, dec-part, expt-part end

  output = int-part + dec-part + expt-part

  if string-length(output) <= max-chars:
    # spy: fixme: 100 end
    output
  else:
    # spy: fixme: 101 end
    shrink-dec(output, max-chars)
  end
end

fun make-unsci(underlying-num-str):
  # spy 'make-unsci of': underlying-num-str end
  e-position = string-index-of(underlying-num-str, 'e')
  if e-position < 0: underlying-num-str
  else:
    underlying-num-str-len = string-length(underlying-num-str)
    mantissa-str = string-substring(underlying-num-str, 0, e-position)
    exponent = string-to-number-i(string-substring(
    underlying-num-str, e-position + 1, underlying-num-str-len))
    mantissa-len = string-length(mantissa-str)
    mantissa-decimal-point-position = string-index-of(mantissa-str, '.')
    mantissa-int-str =
    if mantissa-decimal-point-position > -1:
      string-substring(mantissa-str, 0, mantissa-decimal-point-position)
    else: mantissa-str
    end
    mantissa-frac-str =
    if mantissa-decimal-point-position > -1:
      string-substring(mantissa-str,
      mantissa-decimal-point-position + 1, mantissa-len)
    else: ''
    end
    if exponent == 0:
      underlying-num-str
    else if exponent > 0:
      mantissa-frac-len = string-length(mantissa-frac-str)
      if mantissa-frac-len == exponent:
        mantissa-int-str + mantissa-frac-str
      else if mantissa-frac-len < exponent:
        mantissa-int-str + mantissa-frac-str +
        string-repeat('0', exponent - mantissa-frac-len)
      else:
        mantissa-int-str +
        string-substring(mantissa-frac-str, 0, exponent) + '.' +
        string-substring(mantissa-frac-str, exponent, mantissa-frac-len)
      end
    else: # ie, exponent < 0
      shadow exponent = 0 - exponent
      mantissa-int-len = string-length(mantissa-int-str)
      if mantissa-int-len == exponent:
        "0." + mantissa-int-str + mantissa-frac-str
      else if mantissa-int-len < exponent:
        "0." + string-repeat('0', (exponent - mantissa-int-len) - 1) +
        mantissa-int-str + mantissa-frac-str
      else:
        string-substring(mantissa-int-str, 0, mantissa-int-len - exponent) +
        "." +
        string-substring(mantissa-int-str, mantissa-int-len - exponent,
        mantissa-int-len)
      end
    end
  end
end

fun shrink-dec-part(dec-part, max-chars) block:
  # spy 'shrink-dec-part of': dec-part, max-chars end
  dec-part-len = string-length(dec-part)
  if max-chars < 0 block:
    'cantfit'
  else if dec-part-len == 0:
    ''
  else:
    girth = get-girth(string-to-number-i(dec-part))
    var left-0-padding-len = dec-part-len - (girth + 1)
    ss1n-str = string-substring(dec-part, 0, max-chars)
    var ss1n = 0
    var ss1n-girth = -1
    if ss1n-str <> '' block:
      ss1n := string-to-number-i(ss1n-str)
      ss1n-girth := get-girth(ss1n)
    else: false
    end
    orig-ss1n-girth = ss1n-girth
    ss2n = string-to-number-i(string-substring(dec-part, max-chars, max-chars + 1))
    # spy: fixme: 177 end
    # spy: dec-part, max-chars, ss1n, ss2n end
    if ss2n >= 5 block:
      ss1n := ss1n + 1
      ss1n-girth := get-girth(ss1n)
    else: false
    end
    if ss1n-girth > orig-ss1n-girth:
      left-0-padding-len := left-0-padding-len - 1
    else: false
    end
    if left-0-padding-len < 0:
      'overflow'
    else:
      left-0-padding = string-repeat('0', left-0-padding-len)
      left-0-padding + num-to-string(ss1n)
    end
  end
end

fun shrink-dec(num-str, max-chars):
  len = string-length(num-str)
  # spy 'shrink-dec of': num-str, max-chars, len end
  if len <= max-chars block: num-str
  else:
    dot-position = string-index-of(num-str, '.')
    var int-part = '0'
    var frac-expt-part = ''
    var frac-part = ''
    var expt-part = ''
    if dot-position < 0 block:
      e-position = string-index-of(num-str, 'e')
      if e-position < 0 block:
        int-part := num-str
      else:
        int-part := string-substring(num-str, 0, e-position)
        expt-part := string-substring(e-position, len)
      end
    else:
      int-part := string-substring(num-str, 0, dot-position)
      frac-expt-part := string-substring(num-str, dot-position + 1, len)
      e-position = string-index-of(frac-expt-part, 'e')
      if e-position < 0 block:
        frac-part := frac-expt-part
      else:
        frac-expt-part-len = string-length(frac-expt-part)
        frac-part := string-substring(frac-expt-part, 0, e-position)
        expt-part := string-substring(frac-expt-part, e-position, frac-expt-part-len)
      end
    end
    # spy: int-part, frac-part, expt-part end
    int-part-len = string-length(int-part)
    frac-part-len = string-length(frac-part)
    expt-part-len = string-length(expt-part)
    int-part-num = string-to-number-i(int-part)
    if int-part-len <= max-chars block:
      # spy: fixme: 302 end
      frac-part-mod = shrink-dec-part(frac-part,
      max-chars - (int-part-len + expt-part-len + 1))
      # spy: frac-part-mod end
      if frac-part-mod == 'cantfit':
        'cantfit'
      else if frac-part-mod == 'overflow':
        # when incoming frac-part is .9999x where x >= 5,
        # it overflows past the decimal point, i.e.,
        # should be rounded to 1
         num-to-string(int-part-num + 1) + expt-part
      else if frac-part-mod == '':
        # no need to add decimal point in this case
         int-part + expt-part
      else:
         int-part + '.' + frac-part-mod + expt-part
      end
    else:
      'cantfit'
    end
  end
end

fun num-to-sci(n, max-chars) block:
  # spy 'num-to-sci of': n, max-chars end
  negativep = (n < 0)
  roughp = num-is-roughnum(n)
  var underlying-num = if negativep: 0 - n else: n end
  # spy: underlying-num end
  underlying-num-str = fake-num-to-fixnum(underlying-num)
  if roughp:
    underlying-num := string-to-number-i(underlying-num-str)
  else: false
  end
  # spy: underlying-num-str end
  underlying-num-str-len = string-length(underlying-num-str)
  prefix = (if roughp: '~' else: '' end) + (if negativep: '-' else: '' end)
  prefix-len = string-length(prefix)
  max-chars-mod = max-chars - prefix-len
  var output = ''
  if not(string-contains(underlying-num-str, 'e')):
    # spy: fixme: 1, max-chars-mod end
    if underlying-num-str-len <= max-chars-mod:
      if not(string-contains(underlying-num-str, '/') or string-contains(underlying-num-str, '.')):
        # this weird special case bc of bigints
        # spy: fixme: 1 end
        output := num-to-string(n)
      else:
        # spy: fixme: 1.1 end
        output := prefix + underlying-num-str
      end
    else if underlying-num == 0:
      output := prefix + '0'
    else:
      girth = num-floor(log-base(10, num-abs(underlying-num)))
      sci-num-str = make-sci(underlying-num, underlying-num-str,
      max-chars-mod)
      # spy: fixme: 2, girth, underlying-num-str, sci-num-str, max-chars-mod end
      # spy: sci-num-str end
      if sci-num-str == 'cantfit':
        output := 'cantfit'
      else if (girth < 0) and (girth > -3):
        # spy: fixme: 2.4 end
        num-mod = shrink-dec(underlying-num-str, max-chars-mod)
        if num-mod == 'cantfit':
          output := 'cantfit'
        else:
          output := prefix + num-mod
        end
      else if string-length(sci-num-str) <= max-chars-mod:
        # spy: fixme: 2.5 end
        output := prefix + sci-num-str
      else if not(string-contains(underlying-num-str, '/')):
        # spy: fixme: 2.6 end
        num-mod = shrink-dec(underlying-num-str, max-chars-mod)
        if num-mod == 'cantfit':
          output := 'cantfit'
        else:
          output := prefix + num-mod
        end
      else:
        # spy: fixme: 3 end
        output := prefix + sci-num-str
      end
    end
  else:
    unsci-underlying-num-str = make-unsci(underlying-num-str)
    # spy "unsci": prefix, underlying-num-str, unsci-underlying-num-str,  max-chars-mod end
    # spy: unsci-num-str-len: string-length(unsci-underlying-num-str) end
    if string-length(unsci-underlying-num-str) <= max-chars-mod:
      output := prefix + unsci-underlying-num-str
    else if underlying-num-str-len <= max-chars-mod:
      output := prefix + underlying-num-str
    else:
      # spy: fixme: 4 end
      num-mod = shrink-dec(underlying-num-str, max-chars-mod)
      if num-mod == 'cantfit':
        output := 'cantfit'
      else:
        output := prefix + num-mod
      end
    end
  end
  if output == 'cantfit':
    raise('Could not fit ' + prefix + underlying-num-str + ' into ' + tostring(max-chars) + ' chars')
  else:
    output
  end
where:

  num-to-sci(0.00000343, 10) is "0.00000343" # max fixnum size (small)
  num-to-sci(0.000000343, 11) is "0.00000343"
  num-to-sci(0.00000343, 8) is "3.43e-6"
  num-to-sci(0.00000343, 9) is "3.43e-6"
  num-to-sci(4564634745675734, 16) is "4564634745675734" # max fixnum size (big)
  num-to-sci(45646347456757342, 17) is "45646347456757342"
  num-to-sci(45646347456757342, 16) is "4.56463474568e16"
  num-to-sci(4564634745675734, 15) is "4.5646347457e15"
  num-to-sci(-45646347456757342.000343, 16) is "-4.5646347457e16"
  num-to-sci(0.000001, 8) is "0.000001"
  num-to-sci(-0.000001, 8) is "-1.0e-6"
  num-to-sci(1/3, 18) is "0.3333333333333333"
  num-to-sci(1/3, 19) is "0.3333333333333333" # extra char is unused due to fixnum precision
  num-to-sci(1/3, 8) is "0.333333"
  num-to-sci(1 + 1/3, 8) is "1.333333"
  num-to-sci(2.712828, 7) is "2.71283" # rounding
  num-to-sci(3.1415962, 8) is "3.141596" # rounding
  num-to-sci(0.011238, 7) is "0.01124" # not 0.01123
  num-to-sci(12387691745124903567102, 7) is "1.24e22" # not 1.23876
  num-to-sci(0.0000000000456, 7) is "4.6e-11" # not 4.56e-1
  num-to-sci(203.680147, 9) is "203.68015" # not 2.0368e2
  num-to-sci(103.40123123,9) is "103.40123" # not 1.0340e2
  num-to-sci(20368014712358, 9) is "2.0368e13"

  num-to-sci(20368.0147, 9) is "20368.015"
  num-to-sci(203680.147, 9) is "203680.15"
  num-to-sci(2036801.47, 9) is "2036801.5"
  num-to-sci(20368014.7, 9) is "20368015" # "2.03680e7"

  num-to-sci(0.00001284567, 8) is "1.285e-5" # "0.00001"
  num-to-sci(0.00001284567, 9) is "1.2846e-5" # "0.000013"
  num-to-sci(0.00001234567, 7) is "1.23e-5" # "1.2e-5"
  num-to-sci(0.000001239567, 8) is "1.240e-6"

  num-to-sci(0.0999999, 5) is "0.100"
  num-to-sci(0.9999999, 5) is "1"

  num-to-sci(9999.99, 3) raises "Could not fit"
end
# print(num-to-sci(23e3, 18))


fun easy-num-repr(n, max-chars) block:
  # spy 'easy-num-repr of': n, max-chars end
  negativep = (n < 0)
  roughp = num-is-roughnum(n)
  prefix = (if roughp: '~' else: '' end) + (if negativep: '-' else: '' end)
  prefix-len = string-length(prefix)
  max-chars-mod = max-chars - prefix-len
  var underlying-num = if negativep: 0 - n else: n end
  underlying-num-str = fake-num-to-fixnum-no-exp(underlying-num)
  if roughp:
    underlying-num := string-to-number-i(underlying-num-str)
  else: false
  end
  decimal-point-position = string-index-of(underlying-num-str, '.')
  underlying-num-str-len = string-length(underlying-num-str)
  # spy: underlying-num, underlying-num-str, underlying-num-str-len, max-chars-mod end
  var int-str = underlying-num-str
  var dec-str = ''
  if decimal-point-position > -1 block:
    int-str := string-substring(underlying-num-str, 0, decimal-point-position)
    dec-str := '0' + string-substring(underlying-num-str, decimal-point-position, underlying-num-str-len)
  else: false
  end
  # spy: int-str, dec-str end
  var output = ''
  if underlying-num == 1 block:
    output := prefix + '1'
  else:
    var min-len-needed = 0
    if underlying-num > 1:
      min-len-needed := string-length(int-str)
    else:
      min-len-needed := (0 - get-girth(underlying-num)) + 2
    end
    # spy: min-len-needed, underlying-num-str-len, max-chars-mod end
    if (min-len-needed <= underlying-num-str-len) and (min-len-needed <= max-chars-mod) and (max-chars-mod <= underlying-num-str-len) block:
      # spy: fixme: 'ez' end
      var rounding-check-p = false
      if max-chars-mod == underlying-num-str-len:
        output := prefix + string-substring(underlying-num-str, 0, max-chars-mod)
      else:
        var num-2 = string-substring(underlying-num-str, 0, max-chars-mod + 1)
        if underlying-num > 1:
          output := prefix + num-to-sci(string-to-number-i(num-2), max-chars-mod)
        else:
          dec-part-mod = shrink-dec-part(string-substring(num-2, 2, string-length(num-2)), max-chars-mod - 2)
          if dec-part-mod == 'cantfit':
            output := 'cantfit'
          else if dec-part-mod == 'overflow':
            output := prefix + '1'
          else:
            output := prefix + '0.' + dec-part-mod
          end
        end
      end
    else:
      output := prefix + num-to-sci(underlying-num, max-chars)
    end
  end
  if output == 'cantfit':
    raise('Could not fit ' + prefix + underlying-num-str + ' into ' + tostring(max-chars) + ' chars')
  else:
    output
  end
where:
  easy-num-repr(0.0001234, 6) is "0.0001"
  easy-num-repr(2343.234, 6) is "2343.2"
  easy-num-repr(0.000000001234, 6) is "1.2e-9"
  easy-num-repr(2343243432.234, 6) is "2.34e9"
  easy-num-repr(~0.082805, 9) is "~0.082805"
  easy-num-repr(0.0999999, 5) is "0.100"
  easy-num-repr(0.9999999, 5) is "1"
  easy-num-repr(9999.99, 3) raises "Could not fit"
end

# fun t():
#   # easy-num-repr(0.0001234, 6)
#   # [list: easy-num-repr(2343.234, 6), "2343.2"]
#   # [list: easy-num-repr(0.000000001234, 6) , 0.000000001234, 6, "1.2e-9"]
#   # [list: easy-num-repr(0.0001234, 6) , "0.0001"]
#   num-to-sci(20368014.7, 9) # "20368015"
#   # num-to-sci(100000, 2)
#   # easy-num-repr(~0.082805, 9)
#   # [list: shrink-dec("0.9999999", 5), shrink-dec-part("99999999", 3)]
#   # num-to-sci(0.099999, 5)
#   # easy-num-repr(0.099999,5)
#   # [list: easy-num-repr(0.0001234, 6), "0.0001"]
#   # [list: num-to-sci(20368014.7, 9), "20368014"]
#   # [list: num-to-sci(0.00001234567, 7), "1.2e-5"]
# end

# num-to-sci(203.680147,9) should evaluate to ~203.6801 instead of ~2.0368e2

#################################################################################
# Trig functions

TRIG_ROUND_DIGITS = 10

fun rough-round-digits(val, digits):
  num-to-roughnum(num-round(val * expt(10, digits)) / expt(10, digits))
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
# Live Survey Functions
fun live-display(gsheetID :: String, sheet-name :: String, columns :: List<String>, visualize)  -> Image block:
  fun get-table(t):
    sheet = load-spreadsheet(gsheetID).sheet-by-name(sheet-name, true)
    builtins.open-table(sheet.load(raw-array-from-list(columns), [raw-array: ]))
  end
  r = reactor:
    init: get-table(nothing),
    to-draw: visualize,
    seconds-per-tick: 2,
    on-tick: get-table
  end
  r.interact()
  visualize(get-table(nothing))
end


# live-survey :: (String, String, List<String> :: (Any -> Image)
fun live-survey(gsheetID, sheet-name, columns, visualize) block:
  live-display(gsheetID, sheet-name, columns, visualize)
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
  t.build-column("_color", lam(r) block: 
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

# given a summary table with columns <col> and "frequency",
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
    .colors(t.column("_color"))
  img = render-chart(series).get-image()
  title = make-title([list:"Distribution of", column-name])
  above(title, img)
end

# no need to check integrity - all parent functions do it first
fun bar-chart-raw(t, ls, vs, column-name) block:
  labels = get-labels(t, ls)
  series = from-list.bar-chart(labels, ensure-numbers(t.column(vs)))
    .colors(t.column("_color"))
  img = render-chart(series)
    .x-axis(column-name)
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
  color-table = distinct-colors(summary, col)
  pie-chart-raw(color-table, col, "frequency", col)
end

image-pie-chart :: (t :: Table, col :: String, f :: (Row -> Image)) -> Image
fun image-pie-chart(t, col, f) block:
  check-integrity(t, [list: col])
  summary = count(t, col)
  images = make-images-from-grouped-rows(summary, col, f)
  series = from-list.image-pie-chart(
    images,
    get-labels(summary, col), 
    ensure-numbers(summary.column("frequency")))
  img = render-chart(series)
    .get-image()
  title = make-title([list:"Distribution of", col])
  above(title, img)
end

bar-chart :: (t :: Table, col :: String) -> Image
fun bar-chart(t, col) block:
  check-integrity(t, [list: col])
  summary = count(t, col)
  color-table = distinct-colors(summary, col)
  bar-chart-raw(color-table, col, "frequency", col)
end

image-bar-chart :: (t :: Table, col :: String, f :: (Row -> Image)) -> Image
fun image-bar-chart(t, col, f) block:
  check-integrity(t, [list: col])
  summary = count(t, col)
  images = make-images-from-grouped-rows(summary, col, f)
  series = from-list.image-bar-chart(
    images,
    get-labels(summary, col), 
    ensure-numbers(summary.column("frequency")))
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
  img = render-chart(series)
    .x-axis(col)
    .y-axis(subcol)
    .get-image()
  title = make-title([list:"Distribution of", subcol, "by", col])
  above(title, img)
end

fun stacked-bar-chart-summarized(t, categories, column-list) block:
  check-integrity(t, [list: categories].append(column-list))
  color-list = column-list.map(lam(_): nextColor() end)
  groups = t.get-column(categories).map(to-repr)
  raw_data = map(lam(col): t.get-column(col) end, column-list)
  zipped_data = map_n(lam(n, _):
      map_n(lam(m,_): raw_data.get(m).get(n) end, 0, raw_data)
    end, 0, raw_data.get(0))
  series = from-list.stacked-bar-chart(
    groups, 
    zipped_data, 
    column-list)
    .colors(color-list)
  render-chart(series).get-image()
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
  img = render-chart(series)
    .x-axis(col + " ⋲ " + subcol)
    .y-axis("frequency")
    .get-image()
  title = make-title([list:"Distribution of", subcol, "by", col])
  above(title, img)
end

fun multi-bar-chart-summarized(t, categories, column-list) block:
  check-integrity(t, [list: categories].append(column-list))
  color-list = column-list.map(lam(_): nextColor() end)
  groups = t.get-column(categories).map(to-repr)
  raw_data = map(lam(col): t.get-column(col) end, column-list)
  zipped_data = map_n(lam(n, _):
      map_n(lam(m,_): raw_data.get(m).get(n) end, 0, raw_data)
    end, 0, raw_data.get(0))
  series = from-list.grouped-bar-chart(
    groups, 
    zipped_data, 
    column-list)
    .colors(color-list)
  render-chart(series).get-image()
end



## DOT PLOTS #############################################

simple-dot-plot :: (t :: Table, vals :: String) -> Image
fun simple-dot-plot(t, vals) block:
  check-integrity(t, [list: vals])
  vs = t.column(vals)
  series = if is-number(vs.get(0)):
    from-list.num-dot-chart()
  else: 
    from-list.dot-chart(vs)
  end
  img = render-chart(series.point-size(8))
    .x-axis(vals)
    .y-axis("frequency")
    .get-image()
  title = make-title([list:"Dot Plot of", vals])
  above(title, img)
end

dot-plot :: (t :: Table, labels :: String, vals :: String) -> Image
fun dot-plot(t, labels, vals) block:
  check-integrity(t, [list: labels, vals])
  ls = t.column(labels).map(to-repr)
  series = if is-number(t.column(vals).get(0)):
    from-list.labeled-num-dot-chart(ls, t.column(vals)).point-size(8)
  else: 
    from-list.dot-chart(t.column(vals))
  end
  img = render-chart(series)
    .x-axis(vals)
    .y-axis("frequency")
    .get-image()
  title = make-title([list:"Dot Plot of", vals])
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
      .y-axis("frequency")
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
      .y-axis("frequency")
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
      .y-axis("frequency")
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
      .y-axis("frequency")
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


fun make-lr-title(fn, r-sqr-num, s-num) :
  r-num = (if  (fn(1) - fn(0)) < 0: -1 else: 1 end) * num-sqrt(r-sqr-num)
  alpha-str = easy-num-repr(fn(2) - fn(1), 8)
  beta-str =  easy-num-repr(fn(0), 8)
  r-str = easy-num-repr(r-num, 6)
  r-sqr-str = easy-num-repr(r-sqr-num, 6)
  S-str     = easy-num-repr(s-num, 9)
  "y=" + alpha-str + "x +" + " " + beta-str + "   r: " + r-str + "  r²: " + r-sqr-str + "  S: " + S-str
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
    s-num = S(t, xs, ys, fn)
    r-sqr-num = Stats.r-squared(t.column(xs), t.column(ys), fn)
    img = render-charts([list: scatter, fn-plot])
      .title(make-lr-title(fn, r-sqr-num, s-num))
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
    s-num = S(t, xs, ys, fn)
    r-sqr-num = Stats.r-squared(t.column(xs), t.column(ys), fn)
    img = render-charts([list: scatter, fn-plot])
      .title(make-lr-title(fn, r-sqr-num, s-num))
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
    s-num = S(t, xs, ys, fn)
    r-sqr-num = Stats.r-squared(t.column(xs), t.column(ys), fn)
    img = render-charts([list: scatter, fn-plot])
      .title(make-lr-title(fn, r-sqr-num, s-num))
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
  S-str       = easy-num-repr(S-value, 10)
  #r-str       = if (R-sqr-value > 0): easy-num-repr(num-sqrt(R-sqr-value)) else: "N/A" end
  r-sqr-str   = easy-num-repr(R-sqr-value, 10)

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
  title-str = "S: " + S-str + "   R-sqr: " + r-sqr-str
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

last-n-rows :: (t :: Table, n :: Number) -> Table
fun last-n-rows(t, n):
  T.table-from-rows.make(raw-array-from-list(t.all-rows().reverse().take(n).reverse()))
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
  g = group(tab, col).build-column("frequency", {(r): r["subtable"].length()}).drop("subtable")
  if is-boolean(g.column("value").get(0)): g
  else: order g: value ascending end
  end
    .rename-column("value", col)
end

#|
fun count-many(tab, cols):
  for fold(shadow grouped from table: col, subtable end, c from cols):
    grouped.stack(table: col, subtable
        row: c, count(tab, c)
      end)
  end
end
|#

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
      missing = subgroups.difference(Sets.list-to-set(segments.get-column(subcol)))
      missing.fold(
        lam(table, subgroup): 
          table.add-row([T.raw-row: {subcol; subgroup}, {"frequency"; 0}])
        end,
        segments)
        .build-column("sortable", lam(shadow r): to-repr(r[subcol]) end)
        .order-by("sortable", true)
        .get-column("frequency")
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

fun transpose(t :: Table) block:
  cols = t.column-names()
  row-names = cols.drop(1)
  first-col = cols.get(0)
  # use the old header row as the first column in the new table
  var new_t = T.table-from-column(first-col, row-names)
  
  split = split-at(1, t.all-columns())
  new-cols = split.prefix.get(0)
  old-rows = split.suffix
  
  # for each column in our new table, mine the old rows for their values
  map_n(lam(n, col) block:
      new_t := new_t.add-column(col, map_n(lam(m, v): old-rows.get(m).get(n) end, 0, row-names))
    end,
    0,
    new-cols)
  new_t
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
