use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

####### Section 1: Variable Definitions ###############

m = 6


####### Section 2:  Examples ##########################

examples: 
  
  negate(m) == abs(m)                 is true
  
  negate(m) == negate(abs(m))         is true
  
  negate(m) == abs(negate(m))         is true
  
  abs(negate(m)) == negate(negate(m)) is true
   
  abs(negate(m)) == negate(abs(m))    is true
  
end


