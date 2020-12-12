import XCTest
import AoC2020Kit
import class Foundation.Bundle

final class AoC2020Tests: XCTestCase {
    let day1Input = """
1721
979
366
299
675
1456
"""

    func testDay1Part1() {
        XCTAssertEqual(Day1(input: "1").part1(), -1)
        XCTAssertEqual(Day1(input: day1Input).part1(), 514579)
    }

    func testDay1Part2() {
        XCTAssertEqual(Day1(input: "2").part2(), -1)
        XCTAssertEqual(Day1(input: day1Input).part2(), 241861950)
    }

    let day2Input = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

    func testDay2Part1() {
        XCTAssertEqual(Day2(input: day2Input).part1(), 2)
    }

    func testDay2Part2() {
        XCTAssertEqual(Day2(input: day2Input).part2(), 1)
    }

    let day3input = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

    func testDay3Part1() {
        XCTAssertEqual(Day3(input: day3input).part1(), 7)
    }

    func testDay3Part2() {
        XCTAssertEqual(Day3(input: day3input).part2(), 336)
    }

    let day4Part1Input = """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"""

    func testDay4Part1() {
        XCTAssertEqual(Day4(input: day4Part1Input).part1(), 2)
    }

    let day4Part2FailuresInput = """
eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007
"""

    func testDay4Part2Failures() {
        XCTAssertEqual(Day4(input: day4Part2FailuresInput).part2(), 0)
    }

    let day4Part2SuccessInput = """
pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
"""

    func testDay4Part2Success() {
        XCTAssertEqual(Day4(input: day4Part2SuccessInput).part2(), 4)
    }

// MARK: - Day 5
    let day5Input = """
FBFBBFFRLR
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
"""
    let day5Part2Input1 = """
BBBBBBBRRR
BBBBBBBRRL
BBBBBBBRLL
"""

    let day5Part2Input2 = """
BBBBBBBRRR
BBBBBBBRRL
"""

    func testDay5SeatID() {
        XCTAssertEqual(Day5.seatID(instructions: "FBFBBFRRLR"), -1)
        XCTAssertEqual(Day5.seatID(instructions: "FBFBBFFFLR"), -1)

        XCTAssertEqual(Day5.seatID(instructions: "FBFBBFFRLR"), 357)
        XCTAssertEqual(Day5.seatID(instructions: "BFFFBBFRRR"), 567)
        XCTAssertEqual(Day5.seatID(instructions: "FFFBBBFRRR"), 119)
        XCTAssertEqual(Day5.seatID(instructions: "BBFFBBFRLL"), 820)
    }

    func testDay5Part1() {
        XCTAssertEqual(Day5(input: day5Input).part1(), 820)
    }

    func testDay5Part2() {
        XCTAssertEqual(Day5(input: day5Part2Input1).part2(), 1021)
        XCTAssertEqual(Day5(input: day5Part2Input2).part2(), -1)
    }

    let day6Input = """
abc

a
b
c

ab
ac

a
a
a
a

b
"""

    func testDay6Part1() {
        XCTAssertEqual(Day6(input: day6Input).part1(), 11)
    }

    func testDay6Part2() {
        XCTAssertEqual(Day6(input: day6Input).part2(), 6)
    }

    let day7Input = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

    func testDay7Part1() {
        XCTAssertEqual(Day7(input: day7Input).part1(), 4)
    }

    let day7Part2Input = """
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
"""

    func testDay7Part2() {
        XCTAssertEqual(Day7(input: day7Input).part2(), 32)
        XCTAssertEqual(Day7(input: day7Part2Input).part2(), 126)
    }

    let day8Input = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""

    func testDay8Part1() {
        XCTAssertEqual(Day8(input: "").part1(), 0)
        XCTAssertEqual(Day8(input: day8Input).part1(), 5)
    }

    func testDay8Part2() {
        XCTAssertEqual(Day8(input: "").part2(), 0)
        XCTAssertEqual(Day8(input: day8Input).part2(), 8)
    }

    let day9Input = """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""

    let day9Part1Input1 = """
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
"""

    let day9Part1Input2 = """
20
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
21
22
23
24
25
45
"""

    func testDay9Part1() {
        XCTAssertEqual(Day9(input: day9Part1Input1 + "\n26").part1(), -1)
        XCTAssertEqual(Day9(input: day9Part1Input1 + "\n49").part1(), -1)
        XCTAssertEqual(Day9(input: day9Part1Input1 + "\n100").part1(), 100)
        XCTAssertEqual(Day9(input: day9Part1Input1 + "\n50").part1(), 50)

        XCTAssertEqual(Day9(input: day9Part1Input2 + "\n26").part1(), -1)
        XCTAssertEqual(Day9(input: day9Part1Input2 + "\n65").part1(), 65)
        XCTAssertEqual(Day9(input: day9Part1Input2 + "\n64").part1(), -1)
        XCTAssertEqual(Day9(input: day9Part1Input2 + "\n66").part1(), -1)

        XCTAssertEqual(Day9(input: day9Input, preambleLength: 5).part1(), 127)
    }

    func testDay9Part2() {
        XCTAssertEqual(Day9(input: day9Part1Input2, preambleLength: 20).part2(), 0)
        XCTAssertEqual(Day9(input: day9Input, preambleLength: 5).part2(), 62)
    }

    let day10Input1 = """
16
10
15
5
1
11
7
19
6
12
4
"""

    let day10Input2 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""

    func testDay10Part1() {
        XCTAssertEqual(Day10(input: day10Input1).part1(), 7*5)
        XCTAssertEqual(Day10(input: day10Input2).part1(), 22*10)
    }

    func testDay10Part2() {
        XCTAssertEqual(Day10(input: day10Input1).part2(), 8)
        XCTAssertEqual(Day10(input: day10Input2).part2(), 19208)
    }

    let day11Input = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""

    func testDay11Part1() {
        XCTAssertEqual(Day11(input: day11Input).part1(), 37)
    }

    func testDay11Part2() {
        XCTAssertEqual(Day11(input: day11Input).part2(), 26)
    }

    let day12Input = """
F10
N3
F7
R90
F11
"""

    let day12Part1Input2 = """
S5
L90
F5
"""

    let day12Part1Input3 = """
E1
W1
L180
F1
"""

    let day12Part2Input2 = """
E1
W1
S1
L90
L180
L270
R90
R180
R270
"""

    func testDay12Part1() {
        XCTAssertEqual(Day12(input: day12Input).part1(), 25)
        XCTAssertEqual(Day12(input: day12Part1Input2).part1(), 0)
        XCTAssertEqual(Day12(input: day12Part1Input3).part1(), 1)
        XCTAssertEqual(Day12(input: "A1").part1(), -1)
    }

    func testDay12Part2() {
        XCTAssertEqual(Day12(input: day12Input).part2(), 286)
        XCTAssertEqual(Day12(input: day12Part2Input2).part2(), 0)
        XCTAssertEqual(Day12(input: "L1").part2(), -1)
        XCTAssertEqual(Day12(input: "R1").part2(), -1)
        XCTAssertEqual(Day12(input: "A1").part2(), -1)
    }

    let day13Input = """
"""

    func testDay13Part1() {
        XCTAssertEqual(Day13(input: day13Input).part1(), 0)
    }

    func testDay13Part2() {
        XCTAssertEqual(Day13(input: day13Input).part2(), 0)
    }
}
