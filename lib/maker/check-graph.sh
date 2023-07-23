#!/bin/bash

# last modified 2023-07-23
node --trace-uncaught -e 'graph = require("./distribution/en-us/dependency-graph.js");require("./distribution/en-us/lib/bootstraplesson.js").configureGraph(graph);'