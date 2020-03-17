//
//  CardCollectionViewModel.swift
//  Cardshark
//
//  Created by Rhett Rogers on 3/16/20.
//  Copyright © 2020 LyokoTech. All rights reserved.
//

import Foundation
import SwiftUI

class CardCollectionViewModel: ObservableObject {

    @Published var cards: [Pokémon.Card] = []
    let set: Pokémon.Set?
    
    func load() {
        guard let set = set else { return }
        Pokémon.API.getCards(for: set) { cards in
            DispatchQueue.main.async { self.cards = cards ?? self.cards }
        }
    }
    
    init(set: Pokémon.Set) {
        self.set = set
    }

}
