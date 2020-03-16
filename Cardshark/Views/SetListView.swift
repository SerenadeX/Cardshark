//
//  SetListView.swift
//  Cardshark
//
//  Created by Rhett Rogers on 3/16/20.
//  Copyright © 2020 LyokoTech. All rights reserved.
//

import Foundation
import SwiftUI

struct SetListView: View {
    
    @ObservedObject var model = SetListViewModel()
    
    var body: some View {
        List(model.sets) {
            Text($0.name)
        }.onAppear {
            self.model.load()
        }
    }
}

struct SetListView_Previews: PreviewProvider {
    static var previews: some View {
        SetListView()
    }
}

