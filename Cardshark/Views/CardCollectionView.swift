//
//  CardCollectionView.swift
//  Cardshark
//
//  Created by Rhett Rogers on 3/16/20.
//  Copyright © 2020 LyokoTech. All rights reserved.
//

import Foundation
import SwiftUI

struct CardCollectionView: View {
    
    let set: Pokémon.Set
    @ObservedObject var model: CardCollectionViewModel
    
    init(set: Pokémon.Set) {
        self.set = set
        model = CardCollectionViewModel(set: set)
    }
    
    var body: some View {
        Text(set.name)
    }
    
    
}
