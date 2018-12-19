//
//  GameManager.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

struct GameManager {
   static let cachedGameURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("cachedGame", isDirectory: false)
   
   static func cache(model:GameModel) {
      let encoded = try! JSONEncoder().encode(model)
      do {
         try encoded.write(to: cachedGameURL, options: [.atomicWrite])
      } catch {
         fatalError("Failed to write item to cache: \(error)")
      }
   }
   
   static func loadFromCache() -> GameModel? {
      guard let data = try? Data(contentsOf: cachedGameURL),
         let decoded = try? JSONDecoder().decode(GameModel.self, from: data) else { return nil }
      return decoded
   }
   
   static func modelInCacheAvailable() -> Bool {
      let fileManager = FileManager.default
      return fileManager.fileExists(atPath: cachedGameURL.path)
   }
   
   static func emptyCache() {
      try? FileManager.default.removeItem(atPath: cachedGameURL.path)
   }
}
