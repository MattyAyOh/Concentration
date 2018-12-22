//
//  DataManager.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

protocol DataManager {
   static var cacheURL : URL {get set}
}

extension DataManager {
   static func saveToCache<T:Codable>(model:T) {
      let encoded = try! JSONEncoder().encode(model)
      do {
         try encoded.write(to: Self.cacheURL, options: [.atomicWrite])
      } catch {
         fatalError("Failed to write item to cache: \(error)")
      }
   }
   
   static func loadFromCache<T:Codable>() -> T? {
      guard let data = try? Data(contentsOf: Self.cacheURL),
         let decoded = try? JSONDecoder().decode(T.self, from: data) else { return nil }
      return decoded
   }
   
   static func modelInCacheAvailable() -> Bool {
      let fileManager = FileManager.default
      return fileManager.fileExists(atPath: cacheURL.path)
   }
   
   static func emptyCache() {
      try? FileManager.default.removeItem(atPath: cacheURL.path)
   }
}
