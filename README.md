# AoC-2020
[![Build Status](https://travis-ci.com/mikezs/AoC-2020.svg?branch=develop)](https://travis-ci.com/mikezs/AoC-2020)
[![codecov](https://codecov.io/gh/mikezs/AoC-2020/branch/develop/graph/badge.svg?token=64OZZEYDTF)](https://codecov.io/gh/mikezs/AoC-2020)
[![Sonarcloud Status](https://sonarcloud.io/api/project_badges/measure?project=com.lapots.breed.judge:judge-rule-engine&metric=alert_status)](https://sonarcloud.io/dashboard?id=com.lapots.breed.judge:judge-rule-engine)

## Advent Of Code 2020

### Project approach

This swift package manager project contains my MacOS command line tool, a framework with all of the logic to solve the puzzles and a test framework to validate against the AoC examples that are given in the puzzle descriptions.

### Running

To run day 1:
- Create a file called day1.txt with your puzzle input
- Then run `swift run 1`  in Terminal

## Implementation notes

### Day 4
- First part was doing the parsing as quickly as possible into a dictionary of `[String:String]` and then checking for the required keys
- Second part I decoded properly into a model and has validation rules that were checked. 

  I also had a bug that was pointed out by @SFrost007 that meant my hex colour validation by checking if the set of characters was a subset of all allowed would have let `#######` be called valid when it wasn't. Updated with a regex 
