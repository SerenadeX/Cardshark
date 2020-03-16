//
//  ImageManager.swift
//  Cardshark
//
//  Created by Rhett Rogers on 2/21/20.
//  Copyright © 2020 LyokoTech. All rights reserved.
//

import Foundation
import UIKit

class ImageManager: ObservableObject {
    
    static let shared = ImageManager()
    
    @Published var imageCache: [URL: URL] = [:]
    
    //TODO: REMOVE FORCE UNWRAP
    static let cacheDirectory: URL? = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("images")
    let queue = DispatchQueue(label: "Cardshark Image Manager", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    enum Error: Swift.Error {
        case cacheDirectoryURLFails
    }
    
    init() {
        do {
            try setupFiles()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func setupFiles() throws {
        guard let cacheDirectory = ImageManager.cacheDirectory else { throw Error.cacheDirectoryURLFails }
        
        guard !FileManager.default.fileExists(atPath: cacheDirectory.path) else { return }
        
        try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: false, attributes: nil)
    }
    
    func retrieveImages(for imageURL: URL, withID id: String, completion: @escaping ((UIImage?) -> Void)) {
        if let cacheDirectory = ImageManager.cacheDirectory?.appendingPathComponent(id).appendingPathExtension(imageURL.pathExtension), FileManager.default.fileExists(atPath: cacheDirectory.path) {
            let image = UIImage(contentsOfFile: cacheDirectory.path)
            DispatchQueue.main.async {
                self.imageCache[imageURL] = cacheDirectory
            }
            completion(image)
            return
        }
        self.queue.async {
            URLSession.shared.downloadTask(with: imageURL) { (tempURL, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                }
                
                guard let tempURL = tempURL, let cacheDirectory = ImageManager.cacheDirectory else { return completion(nil) }
                
                let newURL = cacheDirectory.appendingPathComponent(id).appendingPathExtension(set.logoURL.pathExtension)
                do {
                    try FileManager.default.moveItem(at: tempURL, to: newURL)
                    let image = UIImage(contentsOfFile: newURL.path)
                    DispatchQueue.main.async {
                        self.imageCache[imageURL] = newURL
                    }
                    completion(image)
                } catch {
                    print(error.localizedDescription)
                }
                
            }.resume()
        }
        
    }
    
    
}
