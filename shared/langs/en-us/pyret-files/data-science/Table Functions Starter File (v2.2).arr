use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

# A TABLE OF SHAPES
# triangle, square, rectangle, circle and ellipse
shapes-table = table: name, corners, color, polygon
  row: "triangle",  3, "blue",  true
  row: "circle",    0, "red",   false
  row: "square",    4, "green", true
  row: "pentagon",  5, "green", true
  row: "hexagon",   6, "blue",  true
  row: "septagon",  7, "red",   true
  row: "octagon",   8, "blue",  true
  row: "ellipse",   0, "green", false
end

# define some sample rows
blue-triangle = row-n(shapes-table, 0)
red-circle    = row-n(shapes-table, 1)



# is-red :: Row -> Boolean
# consumes a Row, and checks if the color is "red"
examples:
  is-red(blue-triangle) is false
  is-red(red-circle)    is true
end
fun is-red(r): r["color"] == "red" end

# is-polygon :: Row -> Boolean
# consumes a Row, and checks if it is a polygon
examples:
  is-polygon(blue-triangle) is true
  is-polygon(red-circle)    is false
end
fun is-polygon(r): r["polygon"] end


# is-triangle :: Row -> Boolean
# consumes a Row, and checks if the shape name contains "triangle"
examples:
  is-triangle(blue-triangle) is true
  is-triangle(red-circle)    is false
end
fun is-triangle(r): string-contains(r["name"], "triangle") end

# lookup-name :: Row -> String
# consumes a Row, and looks up the name
examples:
  lookup-name(blue-triangle) is "triangle"
  lookup-name(red-circle)    is "circle"
end
fun lookup-name(r): r["name"] end