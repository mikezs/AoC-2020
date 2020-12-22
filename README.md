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
*Refactored to make the code slightly more readable and concise after comparing with other solutions. Also removed force-unwraps because I plan to validate with SwiftLint*

### Day 8
- Implementing an machine code language is always fun! I implemented the instruction interpreter and added a flag for if the instruction had already been visited. Relatively straightforward.
- Next part meant a slightly different interpreter that failed in the event of a loop, rather than returning the current accumulator value. Then I looped over the whole program switching each operation like described and it worked first time.
*This has been my favorite challenge so far!*

### Day 9
- Not particularly happy with this part 1 implementation. I just did nested loops, slicing the array and making sure I didn't go out of bounds. Not an elegant solution, but works.
- My solution to part 2 I'm really happy with and [Tim](https://github.com/timsearle/) mentioned it's an interview question he's seen recently. This was a breadth first search (doing slices of the whole array, for each size going up from 2) and it's really fast compared to the other players (but I'm not sure why) 
*Note: I went back and added lots more test cases from the challenge.*

### Day 10 - There's an easier way than recursion
- Relatively easy implementation, just count the number of times the number ahead of you in the sorted array is +3 or +1
- This took me blooming ages. I made a (I think working) recursive solution, but after running it for 10 mins on my laptop it wasn't finished so obviously not write. Cracked out the old pen and paper and realised that there are sets of loops in a graph where the items are 1 apart (between 2 and 5 times in my input) seperated by gaps of 3 (see why we counted those in the first part? No gaps of 2!). This meant that we could just multiply the number of permutations in each group of 1-seperated numbers. We also need to check position 1 and 2 in the array since if either of these are 2 and 3 (starting at 1) we've got to add those too.
*After reviewing [Simon](https://github.com/SFrost007/AdventOfCode2020/)'s code, he came up with a better solution than me, [check it out](https://github.com/SFrost007/AdventOfCode2020/blob/master/AdventOfCode2020/Day10.swift#L51).*

### Day 11 - Conways Game Of Life
- Classic conways game of life, but without the iteration lifespan. I guessed part 2 would involve implementing this so I took a chance and implemented a data structure to represent a seat. Running unoptimised (debug) was 100 times slower than release.
- This was the same as the first question, but increasing the distance you searched in each direction until you found a seat (not a lifespan, drat). I ran this solution for a minute unoptimised, then switched to optimised (release) and it still took over 10 seconds to run! This may have taken hours to run on debug or in a playground.
*I'm planning to go back and write a better solution to the "found in direction" mechanism and I can remove my `Seat` object and just use a 2-dimentional array of optional `Bool`s*

### Day 12 - [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language))
- Implementing the glassic Logo game. I remember playing this as a kid at school moving a turtle around the screen and drawing a line. I had a bug where rotate left and rotate right were implemented the same, just in a different way, so there's a test specifically for that logic.
- Improving on the last solution with vector maths instead of orthagonal. [GCSE](https://en.wikipedia.org/wiki/General_Certificate_of_Secondary_Education) maths taught me this question is basically always asked about ships because they can move in any direction.
*Instead of comparing strings each loop, I converted the Logo instructions into an enum and pre-processed and it was about 1,000 times faster* 

### Day 13 - Factorization
- First part was a "simple" loop to find the answer, ran pretty quickly.
- Second part however took **3 and a half hours** using an optimised build to find the answer. Basically you've been given the factors of a really large number and you've got to find the number (reverse encryption?). I picked the largest bus number as my number to loop by, but I expect it's probably way more efficient to find a number where all of the busses (at their offset) are the common denominators and loop with that.
*This problem is obviously designed so you're not meant to be able to do the unoptimised search like I did. Luckily I anticipated this and made an optimised build and ran it for hours on a fast computer. I will try to find a better number to loop with.*

### Day 14 - The 3 Bitwise Men
- After reading the question, it was obvious that we needed to bitshift, so I went about converting a string to binary (thanks stackoverflow) but I used a regex helper extension to string I made, which I used incorrectly, so that cost me lots of time. After I'd got it working, the only other complexity was forcing a bit to be zero. I kept track of bits to be 1 and bits to be 0, and applied them seperately.
- Next part required looping through all possible combinations for certain bits, so these were generated as a power of 2 for the number of bits, then each bit was shifted to the position the bit was meant to be in. I still needed to keep track of the bits that should be 0 and should be 1, apply these and output all the memory locations as an array.
*This has to be run on a 64-bit system to not overflow the 36-bit numbers. Some languages would have lots of additional complexity to implement this.*

### Day 15 - Step back debugging
- I initially implemented part 1 using 2 dictionaries, one that was the previous step, and one that was the current. This worked fine, for part 1, just using the value as the key and the position it was last seen as the value.
- Turns out it did not scale for 30 million iterations. Instead of having a dictionary for the current step I just used a tuple for the next value to be added and applied it after i'd done the logic.
*Note: The unit tests for this take about 50 seconds to run, so I've left them commented out and a loop for 3000 to test part 2 was left*

### Day 16 - [Drop in a logic bomb](https://en.wikipedia.org/wiki/Logic_bomb#Fictional_logic_bombs)
- After parsing all the input into a structure and utilising Swift's `ClosedRange` type part 1 was trivial to add invalid numbers to an array and sum them
- Next part was made up of lots of operations and then a loop applying some logic until it couldn't be applied any more and reducing and multiplying the output. I really enjoyed doing this one.
*Note: I've refactored as much as I can into functional chains while still keeping readability. This was another fun task!*

### Day 17 - 3D Conways Game Of Life
- I wrote a "proper" implementation for this splitting each logical operation into it's own function. I actually wrote it correctly first try, but I had 2 stupid copy/paste bugs that prevented me getting the correct solution.
- Adding another dimension just meant adding another parameter to the functions.
*Note: In the interest of time, I just over-wrote my part 1 implementation, but I plan to refactor it so I can have `n` dimensions*

### Day 18 - Calculator
- I wrote a full on Tokenizer/Lexer/Parser/Interpreter from an example I wrote as part of my Programming Langugages Module from Kent Uni. Unfortunately it didn't work properly, so I just used what I'm good at: Regular Expressions and string manipulation. First loop was things in brackets, second loop was the first match in [0-9]+[+*][0-9]+
- Part 2 was changing the similar, but using a loop with `+` in the middle, then a loop with `*` in the middle.
*Note: I want to refactor this so I can provide a regular expression, and replace it's first match with a closure result. **Now done.***

### Day 19 - The Giant Regular Expression
- I used recursion to generate a massive regular expression (3751 characters) and just put it into the Swift `NSRegularExpression` class to parse my input. It's incredibly fast because a deterministic finite automata is created and runs a filter over the input.
- Part 2 required modifications to my regex generation to replace the rules, but I don't want to handle loops, so I generated (some) sub-matches that are a subset of the infinite problem.
*Note: the 3 extra is a magic number. The solution should work for >n extra sub-sets, where n is the exact number. 4 gives the same result (how I knew it was correct) but 5, 6, 7, 8, 9 and 10 give the wrong answer.*

### Day 20

### Day 21

### Day 22 - Card game 
- Implementing a few rules and then running the game until a winner was found for part 1, relatively straight forward. I had gambled that another player would be introduced and made it do any number of players could play the game.
- However, there was recursion introduced in the game, so some rounds were played recursively. Luckily an array of hashable items is also hashable, so I just used the hash for each players deck to check if they had played it before.
*Note: I could have refactored more of the common elements out into static functions, so this will be an exercise when I get more time.*
