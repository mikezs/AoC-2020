import Foundation

public final class Day22: Day {
    public typealias Card = Int
    public typealias Deck = [Card]
    public typealias Game = [Deck]
    public typealias Player = Int

    private let input: Game

    public init(input: String) {
        let players = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        var cards = Game()

        players.forEach {
            cards.append($0.components(separatedBy: .newlines)
                            .enumerated()
                            .reduce([Int](), { array, tuple -> Deck in
                                let (index, card) = tuple
                                return index == 0 ? array : array + [Int(card)!]
                            }))
        }

        self.input = cards
    }

    public static func score(for deck: Deck) -> Int {
        deck
            .enumerated()
            .reduce(0, {
                $0 + ((deck.count - $1.0) * $1.1)
            })
    }

    public func part1() -> Int {
        var players = input
        var winningPlayer: Int?

        while winningPlayer == nil {
            var playedCards = [Card: Player]()

            for playerNumber in 0..<players.count {
                //print("Player \(playerNumber + 1)'s deck: \(players[playerNumber].map { String($0)}.joined(separator: ", "))")
                let playedCard = players[playerNumber].remove(at: 0)
                playedCards[playedCard] = playerNumber
                //print("Player \(playerNumber + 1)'s plays: \(playedCard)")
            }

            let sortedCards: [Card] = playedCards.keys.sorted().reversed()
            let winRoundPlayer = playedCards[sortedCards[0]]!

            //print("Player \(winRoundPlayer + 1) wins the round!\n")

            players[winRoundPlayer] += sortedCards

            let aPlayerHasWon = players
                .enumerated()
                .filter { $0.0 != winRoundPlayer }
                .allSatisfy { $0.1.count == 0 }

            if aPlayerHasWon {
                winningPlayer = winRoundPlayer
            }
        }

        if let winningPlayer = winningPlayer {
            return Day22.score(for: players[winningPlayer])
        }

        return -1
    }

    public static func winner(of game: Game) -> (Player, Game) {
        var hashedDecks = [Player: [Int]]()
        var winningPlayer: Player?
        var game = game

        while winningPlayer == nil {
            // Check the decks haven't been played before
            for (player, deck) in game.enumerated() {
                let deckHash = deck.hashValue

                if hashedDecks[player]?.contains(deckHash) == true {
                    return (0, game)
                }

                hashedDecks[player] = (hashedDecks[player] ?? []) + [deckHash]
            }

            // Draw cards and check if we need to play a sub-game
            var playedCards = [Card: Player]()
            var shouldPlaySubGame = true
            var subGame = Game()

            for playerNumber in 0..<game.count {
                let playedCard = game[playerNumber].remove(at: 0)
                shouldPlaySubGame = shouldPlaySubGame && game[playerNumber].count >= playedCard

                if shouldPlaySubGame {
                    subGame.append(Array(game[playerNumber][0..<playedCard]))
                }

                playedCards[playedCard] = playerNumber
            }

            // Determine the winner
            let roundWinner: Player
            let sortedCards: [Card]

            if shouldPlaySubGame {
                let (subGameWinner, _) = winner(of: subGame)
                roundWinner = subGameWinner
                sortedCards = playedCards
                    .sorted { lhs, _ in lhs.value == roundWinner }
                    .map { $0.key }
            } else {
                sortedCards = playedCards.keys.sorted().reversed()
                roundWinner = playedCards[sortedCards[0]]!
            }

            // Add the cards to the appropriate deck
            game[roundWinner] += sortedCards

            // Check if someone won
            let aPlayerHasWon = game
                .enumerated()
                .filter { $0.0 != roundWinner }
                .allSatisfy { $0.1.count == 0 }

            if aPlayerHasWon {
                winningPlayer = roundWinner
            }
        }

        if let winningPlayer = winningPlayer {
            return (winningPlayer, game)
        }

        return (-1, game)
    }

    public func part2() -> Int {
        let game = input
        let (winner, gameResult) = Day22.winner(of: game)

        return Day22.score(for: gameResult[winner])
    }
}

