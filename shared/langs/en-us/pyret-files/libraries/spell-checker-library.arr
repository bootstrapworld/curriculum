use context starter2024
provide *
import gdrive-sheets as GS
include string-dict
import sets as S

s2ls = S.list-to-tree-set

word-sheet = GS.load-spreadsheet("1RlwxGM1oZd6VfJDwuVNxGIwznB2yGyjwfuKHdXg6Gz8")

fun get-words-from-sheet(sheet-name :: String) -> S.Set<String>:
  s2ls(extract all-words from
      load-table: all-words :: String
        source: word-sheet.sheet-by-name(sheet-name, true)
      end
    end)
end

WORDS-ALL = get-words-from-sheet("All-Words")
WORDS = get-words-from-sheet("Words")
WORDS-1000 = get-words-from-sheet("Words-1000")
WORDS-100  = get-words-from-sheet("Words-100")

var all-seen-words = [mutable-string-dict: ]
var words-worklist = [mutable-string-dict: ]

fun init-vars() block:
  all-seen-words := [mutable-string-dict: ]
  words-worklist := [mutable-string-dict: ]
end

fun word-mod(cps :: List<Number>, replace :: (Number -> List<Number>))
  -> Nothing:
  mods = for map(i from range(0, cps.length())):
    result = split-at(i, cps)
    {this-char; suf} =
      if is-empty(result.suffix):
        {empty; empty}
      else:
        {result.suffix.first; result.suffix.rest}
      end
    result.prefix + replace(this-char) + suf
  end
  mod-words = map(string-from-code-points, mods)
  for each(w from mod-words):
    cases (Option) all-seen-words.get-now(w):
      | none => 
        words-worklist.set-now(w, true)
      | some(count) =>
        all-seen-words.set-now(w, 1 + count)
    end
  end
  #  word-mod(string-to-code-points("hell"), {(_): empty}) is
  #  [S.tree-set: "hel", "hll", "ell"]
end

all-letters-cps = 
  map(string-to-code-point, string-explode('abcdefghijklmnopqrstuvwxyz'))

fun edits1(w :: String) -> Nothing block:
  doc: "All edits that are one edit away from `word`"
  w-cps = string-to-code-points(w)
  with-dels = word-mod(w-cps, {(_): empty})

  # replace
  each({(l): word-mod(w-cps, {(_): [list: l]})}, all-letters-cps)
  # insert before
  each({(l): word-mod(w-cps, {(c): [list: l, c]})}, all-letters-cps)
  # insert after
  each({(l): word-mod(w-cps, {(c): [list: c, l]})}, all-letters-cps)

  # now `words-worklist` has been populated with all the distance 1 edits
  nothing

  #where:
  #  edits1("a").size() is 78
  #  edits1("x").size() is 78
end

fun edits2(w :: String) -> Nothing block:
  edits1(w)
  e1l = words-worklist.keys-now().to-list()
  
  for each(e1w from e1l):
    cases (Option) all-seen-words.get-now(e1w) block:
      | none =>
        all-seen-words.set-now(e1w, 0)
        edits1(e1w)
      | some(count) =>
        all-seen-words.set-now(e1w, 1 + count)
    end
  end
  # now `words-worklist` has been populated with all distance 1 and 2 edits
end

fun find-worklist-words(dict :: S.Set<String>) -> S.Set<String> block:
  valid-edits = [mutable-string-dict: ]
  e12l = words-worklist.keys-now().to-list()
  for each(e12w from e12l):
    when dict.member(e12w):
      valid-edits.set-now(e12w, true)
    end
  end
  
  valid-edits.keys-now()
end

fun time(thk):
  start = time-now()
  r = thk()
  stop = time-now()
  {r; stop - start}
end

#|
   fun alt-words(s :: String, dict :: S.Set<String>) block:
  when string-length(s) > 7:
    raise("The word must be 7 or fewer letters; '" + s + "' has length " + num-to-string(string-length(s)))
  end
  init-vars()
  edits2(s)
  ws = find-worklist-words(dict).to-list()
  for each(w from ws):
    print(w)
  end
end
|#

fun alt-words(orig-s :: String, dict :: S.Set<String>) block:s = string-to-lower(orig-s)
  when string-length(s) > 7:
    raise("The word must be 7 or fewer letters; '" + s + "' has length " + num-to-string(string-length(s)))
  end
  init-vars()
  edits2(s)
  ws = find-worklist-words(dict).to-list()
  wsl = ws.length()
  ask block:
    | wsl == 0 then: 
      print("No matches found")
      nothing
    | wsl == 1 then:
      print("1 match found:")
      for each(w from ws):
        print(w)
      end
    | wsl > 1 then:
      print(num-to-string(wsl) + " matches found:")
      for each(w from ws):
        print(w)
      end 
  end
end
