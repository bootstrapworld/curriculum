#! /usr/bin/env bash

# last modified 2026-01-20

# check integrity of dependency-graph
node --trace-uncaught -e 'graph = require("./distribution/en-us/lib/dependency-graph.js");require("./distribution/en-us/lib/bootstraplesson.js").configureGraph(graph);'
