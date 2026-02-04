#! /usr/bin/env bash

# last modified 2026-01-20

# check integrity of images dictionary
node --trace-uncaught -e 'imagejs = require("./distribution/en-us/lib/images.js");'
