//
//  Pokémon.swift
//  Cardshark
//
//  Created by Rhett Rogers on 3/16/20.
//  Copyright © 2020 LyokoTech. All rights reserved.
//

import Foundation
import UIKit

struct Pokémon {
    
    struct Set: Codable, Identifiable {
        var id: String { return code }
        let code: String
        let ptcgoCode: String?
        let name: String
        let series: String
        let totalCards: Int
        let standardLegal: Bool
        let expandedLegal: Bool
        let releaseDate: Date
        let symbolURL: URL
        let logoURL: URL
        let updatedAt: Date
        
        struct Root: Codable {
            let sets: [Set]
        }
        
        enum CodingKeys: String, CodingKey {
            case code, ptcgoCode, name, series, totalCards, standardLegal, expandedLegal, releaseDate, updatedAt
            case symbolURL = "symbolUrl"
            case logoURL = "logoUrl"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            code = try container.decode(String.self, forKey: .code)
            ptcgoCode = try container.decodeIfPresent(String.self, forKey: .ptcgoCode)
            name = try container.decode(String.self, forKey: .name)
            series = try container.decode(String.self, forKey: .series)
            totalCards = try container.decode(Int.self, forKey: .totalCards)
            standardLegal = try container.decode(Bool.self, forKey: .standardLegal)
            expandedLegal = try container.decode(Bool.self, forKey: .expandedLegal)
            
            if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
                releaseDate = DateFormatter.csDateFormatter.date(from: releaseDateString)!
            } else {
                releaseDate = try container.decode(Date.self, forKey: .releaseDate)
            }
            
            symbolURL = try container.decode(URL.self, forKey: .symbolURL)
            logoURL = try container.decode(URL.self, forKey: .logoURL)
            
            if let úpdatedAtString = try container.decodeIfPresent(String.self, forKey: .updatedAt) {
                updatedAt = DateFormatter.expandedCSDateFormatter.date(from: úpdatedAtString)!
            } else {
                updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            }
            
            loadImages()
        }
        
        func loadImages() {
            ImageManager.shared.retrieveImages(for: symbolURL, withID: "\(id).symbol", completion: { _ in })
            ImageManager.shared.retrieveImages(for: logoURL, withID: "\(id).logo", completion: { _ in })
        }
        
    }
    
    struct Card: Codable {
        let id: String
        let name: String
        let nationalPokédexNumber: Int
        let imageURL: URL
        let imageURLHiRes: URL
        let types: [String]
        let superType: String
        let subType: String
        let hp: Int
        let retreatCost: [String]
        let convertedRetreatCost: Int
        let number: Int
        let artist: String
        let rarity: String
        let series: String
        let set: String
        let setCode: String
        let attacks: [Attack]
        let resistance: [StatAdjust]
        let weaknesses: [StatAdjust]
        
        
        
    }
    
    
    struct Attack: Codable {
        let cost: [String]
        let name: String
        let text: String
        let damage: Int
        let convertedEnergyCost: Int
    }
    
    struct StatAdjust: Codable {
        let type: String
        let value: Int
    }
    
}
