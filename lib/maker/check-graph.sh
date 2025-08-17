#! /usr/bin/env bash

# last modified 2025-07-11
node --trace-uncaught -e 'graph = require("./distribution/en-us/lib/dependency-graph.js");require("./distribution/en-us/lib/bootstraplesson.js").configureGraph(graph);'
