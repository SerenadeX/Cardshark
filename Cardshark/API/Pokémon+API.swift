//
//  Pokémon+API.swift
//  Cardshark
//
//  Created by Rhett Rogers on 3/16/20.
//  Copyright © 2020 LyokoTech. All rights reserved.
//

import Foundation

extension Pokémon {
    
    struct API {
        
        static let baseURL = URL(string: "https://api.pokemontcg.io/v1")!
        
        static func getSets(with id: String? = nil, name: String? = nil, page: Int? = nil, pageSize: Int? = nil, completion: @escaping ([Set]?) -> Void) {
            var url = baseURL.appendingPathComponent("/sets")
            if let id = id {
                url.appendPathComponent("/\(id)")
            }
            
            var queryParameters = [URLQueryItem]()
            if let name = name {
                queryParameters.append(URLQueryItem(name: "name", value: name))
            }
            if let page = page {
                queryParameters.append(URLQueryItem(name: "page", value: "\(page)"))
            }
            if let pageSize = pageSize {
                queryParameters.append(URLQueryItem(name: "pageSize", value: "\(pageSize)"))
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = queryParameters.isEmpty ? nil : queryParameters
            let newURL = components.url!
            dump(newURL)
            let request = URLRequest(url: newURL)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    dump(error)
                    completion(nil)
                }
                
                if let response = response {
                    dump(response)
                }
                
                if let data = data {
                    let dumpString = true
                    if dumpString {
                        dump(String(data: data, encoding: .utf8))
                    }
                    
                    do {
                        let root = try JSONDecoder().decode(Set.Root.self, from: data)
                        completion(root.sets)
                    } catch {
                        dump(error)
                        completion(nil)
                    }
                    
                }
            }.resume()
            
        }
        
    }
    
}
