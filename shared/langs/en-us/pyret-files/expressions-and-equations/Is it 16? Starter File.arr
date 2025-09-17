use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

########### Section 1 ###########################

examples:
  
  num-expt(2, 4)           == 16 is true
  (num-expt(2, 3) + 10)    == 16 is true
  (4 * num-expt(1, 4))     == 16 is true
  (2 * num-expt(2, 3))     == 16 is true
  (2 * 2 * num-expt(2, 2)) == 16 is true
  (num-expt(4, 2) * 2)     == 16 is true
  (num-expt(4, 3) / 2 / 2) == 16 is true
  (num-expt(4, 3) / 2 / 2) == 16 is true

end


########### Section 2 ###########################

examples:
  
  (num-expt(6, 2) - 11) == 25 is true

end