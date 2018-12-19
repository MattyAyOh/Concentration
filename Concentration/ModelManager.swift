//
//  ModelManager.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

struct ModelManager {
   static let cacheDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("localModel", isDirectory: false)
   
   static func cache(model:ConcentrationModel) {
      let encoded = try! JSONEncoder().encode(model)
      do {
         try encoded.write(to: cacheDirectory, options: [.atomicWrite])
      } catch {
         fatalError("Failed to write item to cache: \(error)")
      }
   }
   
   static func loadFromCache() -> ConcentrationModel? {
      guard let data = try? Data(contentsOf: cacheDirectory),
         let decoded = try? JSONDecoder().decode(ConcentrationModel.self, from: data) else { return nil }
      return decoded
   }
   
   static func modelInCacheAvailable() -> Bool {
      let fileManager = FileManager.default
      return fileManager.fileExists(atPath: cacheDirectory.path)
   }
}