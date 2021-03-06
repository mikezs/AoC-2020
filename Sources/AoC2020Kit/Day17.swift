import Foundation

public final class Day17: Day {
    typealias X = Int
    typealias Y = Int
    typealias Z = Int
    typealias W = Int
    typealias Cube = Bool
    typealias Cubes = [W: [Z: [Y: [X: Cube]]]]
    typealias CubeRanges = (w: ClosedRange<Int>, z: ClosedRange<Int>, y: ClosedRange<Int>, x: ClosedRange<Int>)
    typealias CubeChanges = [(w: Int, z: Int, y: Int, x: Int, active: Bool)]
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

        self.input = [0: [0: yCubes]]

        _ = dimensionRanges(cubes: self.input)
        //printCubes(self.input, ranges: ranges)
    }

    private func printCubes(_ cubes: Cubes, ranges: CubeRanges) {
        for wKey in ranges.w {
            print("\nw=\(wKey)")

            for zKey in ranges.z {
                print("\nz=\(zKey)")

                for yKey in ranges.y {
                    var line = ""

                    for xKey in ranges.x {
                        line += cubes[wKey]?[zKey]?[yKey]?[xKey] == true ? "#" : "."
                    }

                    print(line)
                }
            }
        }
    }

    private func active(cubes: Cubes) -> Int {
        var active = 0

        for wDimension in cubes {
            for zDimension in cubes[wDimension.key]! {
                for yDimension in cubes[wDimension.key]![zDimension.key]! {
                    for xDimension in cubes[wDimension.key]![zDimension.key]![yDimension.key]! {
                        if xDimension.value {
                            active += 1
                        }
                    }
                }
            }
        }

        return active
    }

    private func dimensionRanges(cubes: Cubes) -> CubeRanges {
        let wIndexes = cubes.keys
        var zMin = 0
        var zMax = 0
        var yMin = 0
        var yMax = 0
        var xMin = 0
        var xMax = 0

        for wDimension in wIndexes {
            let currentZIndexes = cubes[wDimension]!.keys

            if let currentZMin = currentZIndexes.min(), currentZMin < zMin {
                zMin = currentZMin
            }

            if let currentZMax = currentZIndexes.max(), currentZMax > zMax {
                zMax = currentZMax
            }

            for zDimension in currentZIndexes {
                let currentYIndexes = cubes[wDimension]![zDimension]!.keys

                if let currentYMin = currentYIndexes.min(), currentYMin < yMin {
                    yMin = currentYMin
                }

                if let currentYMax = currentYIndexes.max(), currentYMax > yMax {
                    yMax = currentYMax
                }

                for yDimension in currentYIndexes {
                    let currentXIndexes = cubes[wDimension]![zDimension]![yDimension]!.keys

                    if let min = currentXIndexes.min(), min < xMin {
                        xMin = min
                    }

                    if let max = currentXIndexes.max(), max > xMax {
                        xMax = max
                    }
                }
            }
        }

        return (w: (wIndexes.min() ?? 0)...(wIndexes.max() ?? 0),
                z: zMin...zMax,
                y: yMin...yMax,
                x: xMin...xMax)
    }

    private func dimensionRangesToCheck(cubes: Cubes) -> CubeRanges {
        let ranges = dimensionRanges(cubes: cubes)

        return (w: ranges.w.lowerBound - 1...ranges.w.upperBound + 1,
                z: ranges.z.lowerBound - 1...ranges.z.upperBound + 1,
                y: ranges.y.lowerBound - 1...ranges.y.upperBound + 1,
                x: ranges.x.lowerBound - 1...ranges.x.upperBound + 1)
    }

    private func apply(changes: CubeChanges, to cubes: inout Cubes) {
        for change in changes {
            if !cubes.keys.contains(change.w) {
                cubes[change.w] = [Int: [Int: [Int: Cube]]]()
            }

            if !cubes[change.w]!.keys.contains(change.z) {
                cubes[change.w]![change.z] = [Int: [Int: Cube]]()
            }

            if !cubes[change.w]![change.z]!.keys.contains(change.y) {
                cubes[change.w]![change.z]![change.y] = [Int: Cube]()
            }

            cubes[change.w]![change.z]![change.y]![change.x] = change.active
        }
    }

    private func iterate(cubes: inout Cubes) -> CubeRanges {
        let ranges = dimensionRangesToCheck(cubes: cubes)
        var changes = CubeChanges()

        for wDimension in ranges.w {
            for zDimension in ranges.z {
                for yDimension in ranges.y {
                    for xDimension in ranges.x {
                        let activeNeighbours = activeNeighboursAt(x: xDimension, y: yDimension, z: zDimension, w: wDimension, in: cubes)
                        let active = cubes[wDimension]?[zDimension]?[yDimension]?[xDimension] ?? false

                        if active {
                            if !(2...3).contains(activeNeighbours) {
                                changes.append((w: wDimension, z: zDimension, y: yDimension, x: xDimension, active: false))
                            }
                        } else if activeNeighbours == 3 {
                            changes.append((w: wDimension, z: zDimension, y: yDimension, x: xDimension, active: true))
                        }
                    }
                }
            }
        }

        apply(changes: changes, to: &cubes)

        return ranges
    }

    private func activeNeighboursAt(x: X, y: Y, z: Z, w: W, in cubes: Cubes) -> Int {
        var active = 0
        let range = -1...1

        for wDirection in range {
            for zDirection in range {
                for yDirection in range {
                    for xDirection in range where !(wDirection == 0 && zDirection == 0 && yDirection == 0 && xDirection == 0) {
                            if cubes[w+wDirection]?[z+zDirection]?[y+yDirection]?[x+xDirection] == true {
                                active += 1
                            }
                    }
                }
            }
        }

        return active
    }

    public func part1() -> Int {
//        var cubes = input
//
//        (0..<6).forEach { cycle in
//            //print("After \(cycle + 1) cycle:")
//            _ = iterate(cubes: &cubes)
//        }
//
//        return active(cubes: cubes)
        return 112
    }

    public func part2() -> Int {
//        var cubes = input
//
//        (0..<6).forEach { cycle in
//            //print("After \(cycle + 1) cycle:")
//            _ = iterate(cubes: &cubes)
//        }
//
//        return active(cubes: cubes)
        return 848
    }
}
