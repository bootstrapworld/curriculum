use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

examples:
  
  expt(5, -2) == (-2 * (-2 * (-2 * (-2 * -2))))        is true
  expt(-4, 6) == (-4 * (-4 * (-4 * (-4 * (-4 * -4))))) is true
  expt(2, -3) == (-3 * -3)                             is true
  negate(expt(8, 3)) == expt(negate(8), 3)             is true
  negate(expt(2, -2)) == expt(2, negate(-2))           is true
  expt(negate(1), 4) == (-1 * (-1 * (-1 * -1)))        is true
    
end

