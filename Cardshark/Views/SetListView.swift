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
    @ObservedObject var imageManager = ImageManager.shared
    
    var body: some View {
        NavigationView {
            
            List(["bob", "carl"], id: \.self) { set in
                
                //                NavigationLink(destination: CardCollectionView(set: set)) {
                //                    HStack {
                //                        (self.imageManager.imageCache[set.symbolURL].flatMap { UIImage(contentsOfFile: $0.path).flatMap { Image(uiImage: $0) } } ?? Image(systemName: "nosign"))
                //                            .resizable()
                //                            .aspectRatio(contentMode: .fit)
                //                            .frame(width: 45, height: 45)
                Text(set)
                //                    }
                //                }
            }
            
            .navigationBarTitle("Sets")
            
        }
        .onAppear {
            print("loading")
            self.model.load()
        }
    }
}

struct SetListView_Previews: PreviewProvider {
    static var previews: some View {
        SetListView()
    }
}

