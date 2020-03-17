//
//  SetListViewModel.swift
//  Cardshark
//
//  Created by Rhett Rogers on 3/16/20.
//  Copyright © 2020 LyokoTech. All rights reserved.
//

import Foundation
import SwiftUI

class SetListViewModel: ObservableObject {
    
    @Published var sets: [Pokémon.Set] = []
    
    func load() {
        Pokémon.API.getSets { sets in
            DispatchQueue.main.async {
                dump(sets?.count)
                self.sets = sets ?? self.sets
            }
        }
    }
    
    
}
