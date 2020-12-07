# AoC-2020
[![Build Status](https://travis-ci.com/mikezs/AoC-2020.svg?branch=develop)](https://travis-ci.com/mikezs/AoC-2020)
[![codecov](https://codecov.io/gh/mikezs/AoC-2020/branch/develop/graph/badge.svg?token=64OZZEYDTF)](https://codecov.io/gh/mikezs/AoC-2020)
[![Sonarcloud Status](https://sonarcloud.io/api/project_badges/measure?project=mikezs_AoC-2020&metric=alert_status)](https://sonarcloud.io/dashboard?id=mikezs_AoC-2020)

## Advent Of Code 2020

This are my solutions to the [Advent Of Code 2020](https://adventofcode.com/2020/) event. This year I've been playing along with [timsearle](https://github.com/timsearle/AdventOfCode2020) and [SFrost007](https://github.com/SFrost007/AdventOfCode2020/), please check out their solutions if you're interested.

### Project approach

This swift package manager project contains my MacOS command line tool, a framework with all of the logic to solve the puzzles and a test framework to validate against the AoC examples that are given in the puzzle descriptions.

The idea is to use the example problems/solutions provided in the puzzles to do TDD, but sometimes (Day 5) there are no examples that allow TDD.

### Running

To run day 1:
- Create a file called day1.txt with your puzzle input
- Then run `swift run AoC-2020 1`  in Terminal

## Implementation notes

### Day 1
*Originally done in a playground, but then added to make complete solution*
- This is called (according to timsearle) two sum and is a common interview question. I did the simplist (read: fastest to implement) solution which is nexted loops.
- More nested loops, luckily 2020 isn't divisible by 3, otherwise my solution might give more than 1 answer (thanks SFrost007)

### Day 2
*Originally done in a playground, but then added to make complete solution*
- Lots of string parsing. A regex might have been more efficient, but I ended up just doing lots of `components(separatedBy:)` which worked for me
- Same again, but another couple of rules

### Day 3
*Written on day 5*
- Quite a basic algorithm, originally written without any input, but then modified
- Same algorithm, but just run multiple times with different parameters

### Day 4
- First part was doing the parsing as quickly as possible into a dictionary of `[String:String]` and then checking for the required keys
- Second part I decoded properly into a model and has validation rules that were checked. 

  I also had a bug that was pointed out by @SFrost007 that meant my hex colour validation by checking if the set of characters was a subset of all allowed would have let `#######` be called valid when it wasn't. Updated with a regex 

### Day 5
- First part of the problem I implemented by having an upper and lower bound for x and Y that I just adjusted each loop depending on the front/back and checked they were the same when the loop finished. I first made a test for generating the seat ID, then another test to find the highest
- Second part I was sad you couldn't use TDD, so I've removed the part2 test, but I will implement a function for the tests that generated inputs with a seat missing and trim the ends ("some" rows are missing).

### Day 6
- Slightly over-engineered this answer because I expected to be getting the ASCII ordinals from the characters in part2, but that never came. Mapped the input to an array of arrays of sets of characters, this let me union all the sets and count the elements to get the answer.
- Didn't require much work, just used the first set of the array as the final set (instead of an empty one) and then did intersections with the rest of the sets in the array.

### Day 7
- From experience I knew this was just a case of modelling this as dictionaries and using a recursive function to do a breadth first search of the graph. It took me a long time to work out how to actually make the function that's called recursively, but once it compiled it worked on the first try. [TDD](https://clean-swift.com/step-by-step-walkthrough-of-ios-test-driven-development-in-swift/) makes solving problems like this a joy.
- I implemented this without reading the problem properly, but I ended up with a recursive loop because I made a silly mistake (always taking the root key rather than using the values I was finding as the new key), but it made me realise I wasn't adding the bags that contained other bags, just multiplying the number of bags by their contents recursively. I refactored and still has the problem, but the debugger showed my mistake.
