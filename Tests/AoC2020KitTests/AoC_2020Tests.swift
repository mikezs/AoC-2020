import XCTest
import AoC2020Kit
import class Foundation.Bundle

final class AoC_2020Tests: XCTestCase {
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

    let day4input = """
"""

    func testDay4Part1() {
        XCTAssertEqual(Day4(input: day4input).part1(), 0)
    }

    func testDay4Part2() {
        XCTAssertEqual(Day4(input: day4input).part2(), 0)
    }
}
