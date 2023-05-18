//
//  SetGame.swift
//  AnimatedSet
//
//  Created by Dennis van den Berg on 18/05/2023.
//

import Foundation

struct SetGame<Deck: SetDeck> {
    typealias Card = Deck.CardType
    typealias FreeIndices = [Int]
    
    // MARK: Properties
    private (set) var deck: Deck
    private (set) var cards: [Card]
    private (set) var matchedCards: Set<Card>
    private (set) var score: Int
    private (set) var hintsLeft: Int
    
    private (set) var dateLastSetMatched: Date {
        didSet {
            timeSinceLastSet = dateLastSetMatched.timeIntervalSince(oldValue)
        }
    }
    private var timeSinceLastSet: TimeInterval
    
    // MARK: Initialiser
    init(deck: Deck) {
        cards = []
        matchedCards = []
        score = 0
        hintsLeft = Constants.MAX_HINTS
        dateLastSetMatched = Date.now
        timeSinceLastSet = 0
        self.deck = deck
        let initialCards = self.deck.deal(amount: Constants.INITIAL_CARDS_TO_DEAL)
        cards.append(contentsOf: initialCards)
    }
}

// MARK: Dealing
extension SetGame {
    var isFinised: Bool {
        // Game is finished when deck is empty and there are no more possible sets in cards
        deck.isEmpty && findMatchingSet() == nil
    }
    
    var canDeal: Bool {
        !deck.isEmpty
    }

    mutating func deal(at freeIndices: FreeIndices? = nil) {
        // It could be that the deal is requested when no card is chosen
        var freeIndices = freeIndices // copy value
        
        // If we had a valid set, get those indices
        if let selection = cardSelectionSet, selection.isValidSet {
            freeIndices = removeSet()
        }
        
        // Get new cards from deck
        var newCards = deck.deal()
        
        // Put those cards in the free indices spot if possible
        if let indices = freeIndices {
            indices.forEach {
                guard let card = newCards.popLast() else {
                    return
                }
                
                cards.insert(card, at: $0)
            }
        } else {
            if findMatchingSet() != nil {
                print("🚨 There was a possible set in the cards shown. Penalty -5")
                score -= 5
            }
            cards.append(contentsOf: newCards)
        }
    }
}

// MARK: Choosing cards
extension SetGame {
    var cardSelectionSet: SetSelection<Card>? {
        get {
            let selectedCards = cards.filter { $0.isSelected }
            guard selectedCards.count == Constants.SET_CARD_COUNT else {
                return nil
            }
            
            return SetSelection(
                firstCard: selectedCards[0],
                secondCard: selectedCards[1],
                thirdCard: selectedCards[2]
            )
        }
        set {
            cards.filter(\.isSelected)
                .compactMap(cards.firstIndex(of:))
                .forEach {
                    cards[$0].isSelected = false
                    cards[$0].isMismatched = false
                }
        }
    }
    
    mutating func chooseCard(at cardIndex: Int) {
        guard cardIndex < cards.count else {
            print("Card index out of bounds")
            return
        }
        
        if let selection = cardSelectionSet {
            // There was a selection of three cards
            if selection.isValidSet {
                // Set was valid. Remove from game and select new card.
                cards[cardIndex].isSelected = true
                let _ = removeSet()
//                deal(at: freeIndices) // Do not deal new cards
            } else {
                // Set was not valid. Undo selection and select new card.
                cardSelectionSet = nil // Will trigger custom set function -> setting `isSelected` to false
                cards[cardIndex].isSelected = true
            }
            
        } else {
            // There was not a selection of three cards yet
            cards[cardIndex].isSelected.toggle()
            // Check if there is a match
            performMatch()
        }
    }
}

// MARK: Matching
extension SetGame {
    mutating func performMatch() {
        // Check if there is a set
        guard let selection = cardSelectionSet else {
            return
        }
        
        let selectionIndices = selection.cards.compactMap(cards.firstIndex(of:))
        
        if selection.isValidSet {
            // If set is valid -> set isMatched
            selectionIndices.forEach { cards[$0].isMatched = true }
            dateLastSetMatched = Date.now
            calculateScore()
        } else {
            // If not -> set isMismatched
            selectionIndices.forEach { cards[$0].isMismatched = true }
            print("❌ Selection is not a valid set! Score -5")
            score -= 5
        }
    }
    
    mutating func removeSet() -> FreeIndices {
        // Add to matched cards
        cards
            .filter { $0.isMatched }
            .forEach { matchedCards.insert($0) }
        
        // Get indices
        let indices = cards.filter { $0.isMatched }
            .compactMap(cards.firstIndex(of:))
        
        // Remove from table cards
        cards.removeAll(where: { $0.isMatched })

        return indices
    }
}

// MARK: Score
extension SetGame {
    mutating func calculateScore() {
        // Calculate a bonus factor by taking the time it took to complete a set since last set
        // Extracting that from 30
        // Calculate a multiplier
        
        let secondsSinceLastSet = min(timeSinceLastSet, Constants.MAX_BONUS_SECONDS)
        let bonus = Constants.MAX_BONUS_SECONDS - secondsSinceLastSet
        let bonusFactor = 1 + (bonus * 0.1)
        
        print("🚀 Bonus points for speed!: \(10 * (bonus * 0.1))")
        print("✅ Selection is a valid set! Score +10")
        score += Int(10 * bonusFactor)
    }
}

// MARK: Hints
extension SetGame {
    mutating func markPossibleSetInCards() {
        if hintsLeft > 0 {
            cards.indices.forEach({ cards[$0].isHint = false })
            if let set = findMatchingSet() {
                set.cards.compactMap(cards.firstIndex(of:)).forEach {
                    cards[$0].isHint = true
                }
            }
            hintsLeft -= 1
            print("💡 You used a hint. Penalty -2")
            score -= 2
        } else {
            print("❗️ No more hints left!")
        }
    }
    
    private func findMatchingSet() -> SetSelection<Card>? {
        let possibleCombinations = Array(cards.indices).combinations(sample: Constants.SET_CARD_COUNT)
        print("Number of cards on table: \(cards.count)")
        print("Possible combinations: \(possibleCombinations.count)")
        
        for combination in possibleCombinations.shuffled() {
            if let set = SetSelection(firstCard: cards[combination[0]],
                                      secondCard: cards[combination[1]],
                                      thirdCard: cards[combination[2]]) {
                if set.isValidSet {
                    return set
                }
            }
        }
        
        return nil
    }
}

fileprivate struct Constants {
    static let INITIAL_CARDS_TO_DEAL = 12
    static let SET_CARD_COUNT = 3
    static let MAX_HINTS = 3
    static let MAX_BONUS_SECONDS: Double = 30.0
}
