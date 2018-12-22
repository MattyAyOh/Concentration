//
//  HistoryManager.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

struct HistoryManager: DataManager {
   static var cacheURL: URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("history", isDirectory: false)
         
   static func addWinToHistory(_ history:HistoryModel) {
      var allHistory:[HistoryModel] = loadFromCache() ?? [HistoryModel]()
      allHistory.insert(history, at: 0)
      saveToCache(model: allHistory)
   }
   
   static func clearHistory() {
      try? FileManager.default.removeItem(atPath: cacheURL.path)
   }
}
