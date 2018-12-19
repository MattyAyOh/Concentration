//
//  ModelManager.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

class ModelManager {
   static let shared = ModelManager()
   static let cacheDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("localModel", isDirectory: false)
   
   class func cache(model:ConcentrationModel) {
      let encoded = try! JSONEncoder().encode(model)
      do {
         try encoded.write(to: cacheDirectory, options: [.atomicWrite])
      } catch {
         fatalError("Failed to write item to cache: \(error)")
      }
   }
   
   class func loadFromCache() -> ConcentrationModel? {
      guard let data = try? Data(contentsOf: cacheDirectory),
         let decoded = try? JSONDecoder().decode(ConcentrationModel.self, from: data) else { return nil }
      return decoded
   }
}
