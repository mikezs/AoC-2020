import Foundation

public final class Day17: Day {
    typealias X = Int
    typealias Y = Int
    typealias Z = Int
    typealias Cube = Bool
    typealias Cubes = [Z: [Y: [X: Cube]]]
    private let input: Cubes

    public init(input: String) {
        var yCubes = [Y: [X: Cube]]()

        for (index, line) in input.trimmedLines.enumerated() {
            var xCubes = [X: Cube]()

            line.enumerated().forEach { index, cube in
                xCubes[index] = cube == "#" ? true : false
            }

            yCubes[index] = xCubes
        }

        self.input = [0: yCubes]

        printCubes(self.input)
    }

    private func printCubes(_ cubes: Cubes) {
        for zKey in cubes.keys.sorted() {
            print("\nz=\(zKey)")

            for yKey in cubes[zKey]!.keys.sorted() {
                var line = ""

                for xKey in cubes[zKey]![yKey]!.keys.sorted() {
                    line += cubes[zKey]![yKey]![xKey]! ? "#" : "."
                }

                print(line)
            }
        }
    }

    private func active(cubes: Cubes) -> Int {
        var active = 0

        for zDimension in cubes {
            for yDimension in cubes[zDimension.key]! {
                for xDimension in cubes[zDimension.key]![yDimension.key]! {
                    if xDimension.value {
                        active += 1
                    }
                }
            }
        }

        return active
    }

    private func iterate(cubes: inout Cubes) {
        for zDimension in cubes {
            for yDimension in cubes[zDimension.key]! {
                for xDimension in cubes[zDimension.key]![yDimension.key]! {
                    let activeNeighbours = activeNeighboursAt(x: xDimension.key, y: yDimension.key, z: zDimension.key, in: cubes)
                    if xDimension.value {
                        if !(2...3).contains(activeNeighbours) {
                            cubes[zDimension.key]?[yDimension.key]?[xDimension.key] = false
                        }
                    }
                }
            }
        }


    }

    private func activeNeighboursAt(x: X, y: Y, z: Z, in cubes: Cubes) -> Int {
        for zDirection in -1...1 {
            for yDirection in -1...1 {
                for xDirection in -1...1
                    where xDirection != 0 && yDirection != 0 && zDirection != 0 {

                }
            }
        }

        return 0
    }

    public func part1() -> Int {
        var cubes = input

        (0..<6).forEach { _ in
            iterate(cubes: &cubes)
            printCubes(cubes)
        }

        return active(cubes: cubes)
    }

    public func part2() -> Int {
        0
    }
}
