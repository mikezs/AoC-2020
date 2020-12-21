import Foundation

typealias Food = String
typealias Ingrediant = String

public final class Day21: Day {
    private let input: [[Food]: Set<Ingrediant>]

    public init(input: String) {
        self.input = input.trimmedLines.reduce([[Food]: Set<Ingrediant>](), {
            let foods = $1.matches(for: "([^(]+ ?)+ \\(contains ([^)]+(, )?)+\\)")
            return $0.adding(key: foods[0][1].components(separatedBy: ", "),
                             value: Set(foods[0][0].components(separatedBy: " ")))
        })
    }

    public func part1() -> Int {
        var singleFoods = [Food: Set<Ingrediant>]()
        var multiFoods = [[Food]: Set<Ingrediant>]()
        var allMultiFoodFoods = Set<Food>()

        input.forEach {
            if $0.key.count == 1 {
                singleFoods[$0.key[0]] = $0.value
            } else {
                let foods = $0.key
                multiFoods[foods] = $0.value

                foods.forEach {
                    allMultiFoodFoods.insert($0)
                }
            }
        }

        var notAllergens = Set<Ingrediant>()

//        for food in singleFoods {
//            for multiFood in multiFoods where multiFood.key.contains(food.key) {
//                food.value
//                    .subtracting(multiFood.value)
//                    .forEach {
//                        notAllergens.insert($0)
//                    }
//            }
//        }

        for multiFood in multiFoods {
            var singleIngrediants = Set<Ingrediant>()

            for food in multiFood.key {
                if let ingrediants = singleFoods[food] {
                    ingrediants.forEach {
                        singleIngrediants.insert($0)
                    }
                }
            }

            multiFood.value
                .symmetricDifference(singleIngrediants)
                .forEach {
                    notAllergens.insert($0)
                }
        }

        for food in singleFoods where !allMultiFoodFoods.contains(food.key) {
            food.value.forEach {
                notAllergens.remove($0)
            }
        }

        var count = 0

        for notAllergen in notAllergens {
            input.forEach {
                if $0.value.contains(notAllergen) {
                    count += 1
                }
            }
        }

        return count //2467 too high
    }

    public func part2() -> Int {
        0
    }
}

