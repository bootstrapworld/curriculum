use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

provide *

include tables
include charts

import lists as L
provide from L: 
  *,
  type *, 
  data *
end

#################################################################
# MYSTERY FUNCTIONS

# non-linear
fun funA(x): num-expt(x, 3) end
fun funD(x): 1 / x end
fun funE(x): num-sqr(x) end
fun funH(x): num-sqrt(x) end
fun funI(x): (10 * x) + 7 end

# linear
fun funB(x): (22 * x) - 200 end
fun funC(x): (1.3 * x) + 2 end
fun funF(x): 6.5 end
fun funG(x): (-6 * x) + 17 end
fun funJ(x): 0 end


#################################################################
# MYSTERY GRAPHS

# non-linear
graphA = lam(): def-to-graph(funA) end
graphD = lam(): def-to-graph(funD) end
graphE = lam(): def-to-graph(funE) end
graphH = lam(): def-to-graph(funH) end
graphI = lam(): def-to-graph(funI) end

# linear
graphB = lam(): def-to-graph(funB) end
graphC = lam(): def-to-graph(funC) end
graphF = lam(): def-to-graph(funF) end
graphG = lam(): def-to-graph(funG) end
graphJ = lam(): def-to-graph(funJ) end

fun show(shadow graph): graph() end

#################################################################
# MYSTERY TABLES

# non-linear
tableG = table: x, y
  row: 1, 50.5
  row: 2, 52
  row: 3, 54.8
  row: 4, 57.2
  row: 5, 58.4
  row: 5.8, 59
  row: 6, 58.9
  row: 6.5, 58.5
  row: 6.8, 58.5
  row: 7, 58.2
  row: 7.5, 57.3
  row: 8, 57
  row: 8.5, 56.3
  row: 9.2, 55.5
  row: 9.8, 55.5
  row: 10, 55
  row: 10.3, 55
  row: 11, 53.5
  row: 11.4, 53.5
  row: 11.5, 52.9
  row: 11.8, 52.9
  row: 12, 52.4
end


tableD = table: x, y
  row: 1, 1
  row: 2, 2
  row: 2, 3
  row: 3, 3
  row: 4, 4
  row: 5, 5
  row: 6, 6
  row: 7, 7
  row: 8, 8
  row: 9, 9
end

tableB = table: x, y
  row: 1, 1
  row: 2, 3
  row: 3, 6
  row: 4, 10
  row: 5, 15
  row: 6, 21
  row: 7, 28
  row: 8, 36
  row: 9, 45
end

# linear
tableE = def-to-table(lam(x): num-sqr(x) - 12 end)
tableA = def-to-table(lam(x): -3 * x end)
tableH = def-to-table(lam(x): (15 * x) + 100 end)
tableF = def-to-table(lam(x): (4/3 * x) - 2 end)
tableC = def-to-table(lam(x): 19 end)


#####################################################################
# TESTING
# Let's make a graph from a table!
# table-to-graph(table1)
#def-to-table(fun3)
#def-to-graph(fun4)