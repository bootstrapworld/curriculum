var langTable = {
  "Number": {
    "primitives": [
      "+", "-", "*", "/", "expt", "mean", 
      "median", "modes", "sqr", "sqrt"
    ],
    "values": ["4", "-1.2", "2/3", "pi"]
  },
  "String": {
    "primitives": ["string-length", "string-repeat", "string-contains?"],
    "values": ["\"hello\"", "\"91\""]
  },
  "Boolean": {
    "primitives": [
      "==", "<", ">", "<>", "<=", ">=", "string-equal",
      "string<?", "string>?", "string=?", "string<>?", 
      "string<=?", "string>=?", "and", "or"
    ],
    "values": ["true", "false"]
  },
  "Image": {
    "primitives": [
      "star", "triangle", "circle", "square", "rectangle", 
      "rhombus", "ellipse", "regular-polygon", "radial-star", 
      "polygon-star", "text", "image-url", "overlay", "put-image", 
      "above", "beside", "below", "rotate", "scale", 
      "flip-horizontal", "flip-vertical", "bar-chart", 
      "stacked-bar-chart", "multi-bar-chart", "pie-chart", 
      "box-plot", "scatter-plot", "lr-plot", "histogram",
      "image-scatter-plot", "image-pie-chart", "image-bar-chart",
      "image-histogram", "image-lr-plot", "fit-model",
      "bar-chart-summarized", "pie-chart-summarized", 
      "modified-box-plot"
    ],
    "values": ["🔵", "🔺", "🔶"]
  },
  "Table": {
    "primitives": [
      "count", "row-n", "sort", "filter", 
      "build-column", "random-rows"
    ],
    "values": ["This whole table is a table!"]
  }
}
