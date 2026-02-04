#! /usr/bin/env bash

# last modified 2026-01-20

# check integrity of standards, practices, etc dictionaries
node --trace-uncaught -e 'dictionariesjs = require("./distribution/en-us/lib/dictionaries.js");'
