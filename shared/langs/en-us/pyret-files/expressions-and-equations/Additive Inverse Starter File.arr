use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

########### 1: The Additive Inverse ################

examples "Part 1":
  
  (54 + -54) == 0        is true
  0 == (-6 + 6)          is true
  (28 + -28) == 0        is true
  (5 + -5) == (-600 + 600) is true
  (-9.2 + 9.2) == 0      is true

end

####### 2: Subtraction = Adding the Opposite ######

examples "Part 2":
  
  (30 -  5) == (30 +   5) is true
  (11 + -9) == (11 -   9) is true
  ( 5 - 30) == (5  - -30) is true
  (24 + -4) == (24 - -4)  is true
  (60 - 55) == (60 + -55) is true
  
end 
  
######### 3: My Own Example Block ###################

examples "Part 3":
  
  (45 + -5) == (45 - 4)   is true
  
end 
