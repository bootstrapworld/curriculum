use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# CONTRACTS
# mood : String -> String

# PURPOSE
# consumes a mood, and produces the emoji for that mood

# EXAMPLES
examples:
  mood("happy") is "😀"
  mood("sad")   is "😥"
  mood("angry") is "😡"
  mood("sick")  is "🤮"
end

# FUNCTION DEFINITION
fun mood(feeling):
ask:
| feeling == "happy" then: "😀"
| feeling == "sad" then: "😥"
| feeling == "angry" then: "😡"
| feeling == "sick" then: "🤮"
| otherwise: "❓"
end
end